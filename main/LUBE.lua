--[[ LICENSE
-- Following is the MIT license as found on
-- http://www.opensource.org/licenses/mit-license.php .

Copyright (c) 2011 Bart van Strien

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

local socket = require "socket"
--assert(socket, "OH NOEESSSSS")
require("ext/!classlib")

-- We use Class Commons
-- For now, you're not. -ZenX2
--assert(common and common.class, "A Class Commons implementation is required")

lube = {}

lube.Client = class()
-- A generic client class
-- Implementations are required to implement the following functions:
--  * createSocket() --> Put a socket object in self.socket
--  * success, err = _connect() --> Connect the socket to self.host and self.port
--  * _disconnect() --> Disconnect the socket
--  * success, err = _send(data) --> Send data to the server
--  * message, err = _receive() --> Receive a message from the server
--  * setOption(option, value) --> Set a socket option, options being one of the following:
--      - "broadcast" --> Allow broadcast packets.
-- And they also have to set _implemented to evaluate to true.
--
-- Note that all implementations should have a 0 timeout, except for connecting.

function lube.Client:__init()
	assert(self._implemented, "Can't use a generic lube.Client object directly, please provide an implementation.")
	-- 'Initialize' our variables
	self.host = nil
	self.port = nil
	self.connected = false
	self.socket = nil
	self.callbacks = {
		recv = nil
	}
	self.handshake = nil
	self.ping = nil
end

function lube.Client:setPing(enabled, time, msg)
	-- If ping is enabled, create a self.ping
	-- and set the time and the message in it,
	-- but most importantly, keep the time.
	-- If disabled, set self.ping to nil.
	if enabled then
		self.ping = {
			time = time,
			msg = msg,
			timer = time
		}
	else
		self.ping = nil
	end
end

function lube.Client:connect(host, port, dns)
	-- Verify our inputs.
	if not host or not port then
		return false, "Invalid arguments"
	end
	-- Resolve dns if needed (dns is true by default).
	if dns ~= false then
		local ip = socket.dns.toip(host)
		if not ip then
			return false, "DNS lookup failed for " .. host
		end
		host = ip
	end
	-- Set it up for our new connection.
	self:createSocket()
	self.host = host
	self.port = port
	-- Ask our implementation to actually connect.
	local success, err = self:_connect()
	if not success then
		self.host = nil
		self.port = nil
		return false, err
	end
	self.connected = true
	-- Send our handshake if we have one.
	if self.handshake then
		self:send(self.handshake .. "+\n")
	end
	return true
end

function lube.Client:disconnect()
	if self.connected then
		self:send(self.handshake .. "-\n")
		self:_disconnect()
		self.host = nil
		self.port = nil
	end
end

function lube.Client:send(data)
	-- Check if we're connected and pass it on.
	if not self.connected then
		return false, "Not connected"
	end
	return self:_send(data)
end

function lube.Client:receive()
	-- Check if we're connected and pass it on.
	if not self.connected then
		return false, "Not connected"
	end
	return self:_receive()
end

function lube.Client:update(dt)
	if not self.connected then return end
	assert(dt, "Update needs a dt!")
	-- First, let's handle ping messages.
	if self.ping then
		self.ping.timer = self.ping.timer + dt
		if self.ping.timer > self.ping.time then
			self:_send(self.ping.msg)
			self.ping.timer = 0
		end
	end
	-- If a recv callback is set, let's grab
	-- all incoming messages. If not, leave
	-- them in the queue.
	if self.callbacks.recv then
		local data, err = self:_receive()
		--if err then print("[CLIENT]: "..err) end
		while data do
			--print("[CLIENTDEBUGGY] RECIEVING: "..data)
			self.callbacks.recv(data)
			data, err = self:_receive()
		end
	end
end

lube.Server = class()
-- A generic server class
-- Implementations are required to implement the following functions:
--  * createSocket() --> Put a socket object in self.socket.
--  * _listen() --> Listen on self.port. (All interfaces.)
--  * send(data, clientid) --> Send data to clientid, or everyone if clientid is nil.
--  * data, clientid = receive() --> Receive data.
--  * accept() --> Accept all waiting clients.
-- And they also have to set _implemented to evaluate to true.
-- Note that all functions should have a 0 timeout.

function lube.Server:__init()
	assert(self._implemented, "Can't use a generic lube.Server object directly, please provide an implementation.")
	-- 'Initialize' our variables
	-- Some more initialization.
	self.clients = {}
	self.handshake = nil
	self.callbacks = {
		recv = nil,
		connect = nil,
		disconnect = nil,
	}
	self.ping = nil
	self.port = nil
end

function lube.Server:setPing(enabled, time, msg)
	-- Set self.ping if enabled with time and msg,
	-- otherwise set it to nil.
	if enabled then
		self.ping = {
			time = time,
			msg = msg
		}
	else
		self.ping = nil
	end
end

function lube.Server:listen(port)
	-- Create a socket, set the port and listen.
	self:createSocket()
	self.port = port
	self:_listen()
end

function lube.Server:update(dt)
	assert(dt, "Update needs a dt!")
	-- Accept all waiting clients.
	self:accept()
	-- Start handling messages.
	local data, clientid = self:receive()
	while data do
		local hs, conn = data:match("^(.+)([%+%-])\n?$")
		if hs == self.handshake and conn == "+" then
			-- If we already knew the client, ignore.
			if not self.clients[clientid] then
				self.clients[clientid] = {ping = -dt}
				if self.callbacks.connect then
					self.callbacks.connect(clientid)
				end
			end
		elseif hs == self.handshake and conn == "-" then
			-- Ignore unknown clients (perhaps they timed out before?).
			if self.clients[clientid] then
				self.clients[clientid] = nil
				if self.callbacks.disconnect then
					self.callbacks.disconnect(clientid)
				end
			end
		elseif not self.ping or data ~= self.ping.msg then
			-- Filter out ping messages and call the recv callback.
			if self.callbacks.recv then
				self.callbacks.recv(data, clientid)
			end
		end
		-- Mark as 'ping receive', -dt because dt is added after.
		-- (Which means a net result of 0.)
		if self.clients[clientid] then
			self.clients[clientid].ping = -dt
		end
		data, clientid = self:receive()
	end
	if self.ping then
		-- If we ping then up all the counters.
		-- If it exceeds the limit we set, disconnect the client.
		for i, v in pairs(self.clients) do
			v.ping = v.ping + dt
			if v.ping > self.ping.time then
				self.clients[i] = nil
				if self.callbacks.disconnect then
					self.callbacks.disconnect(i)
				end
			end
		end
	end
end

-- And now, implementations!

-- First, UDP.
lube.udpClient = class(lube.Client)
lube.udpClient._implemented = true

function lube.udpClient:createSocket()
	self.socket = socket.udp()
	self.socket:settimeout(0)
end

function lube.udpClient:_connect()
	-- We're connectionless,
	-- guaranteed success!
	return true
end

function lube.udpClient:_disconnect()
	-- Well, that's easy.
end

function lube.udpClient:_send(data)
	if self.host and self.port then
		return self.socket:sendto(data, self.host, self.port)
	end
end

function lube.udpClient:_receive()
	local data, ip, port = self.socket:receivefrom()
	--if ip ~= "timeout" then print("[CLIENT]: RECIEVING FROM: "..ip..":"..(port or "(no port)").."\nData: "..data) print("But... My ip:port is "..self.host..":"..self.port) end
	if ip == self.host and tonumber(port) == tonumber(self.port) then
		--print("It's cool.")
		return data
	end
	return false, "Unknown remote sent data."
end

function lube.udpClient:setOption(option, value)
	if option == "broadcast" then
		self.socket:setoption("broadcast", not not value)
	end
end

lube.udpServer = class(lube.Server)
lube.udpServer._implemented = true

function lube.udpServer:createSocket()
	self.socket = socket.udp()
	self.socket:settimeout(0)
end

function lube.udpServer:_listen()
	self.socket:setsockname("*", self.port)
end

function lube.udpServer:send(data, clientid)
	-- We conveniently use ip:port as clientid.
	if clientid then
		local ip, port = clientid:match("^(.-):(%d+)$")
		self.socket:sendto(data, ip, tonumber(port))
	else
		for clientid, _ in pairs(self.clients) do
			local ip, port = clientid:match("^(.-):(%d+)$")
			self.socket:sendto(data, ip, tonumber(port))
		end
	end
end

function lube.udpServer:receive()
	local data, ip, port = self.socket:receivefrom()
	if data then
		local id = ip .. ":" .. port
		return data, id
	end
	return nil, "No message."
end

function lube.udpServer:accept()
end

-- But also, TCP.
lube.tcpClient = class(lube.Client)
lube.tcpClient._implemented = true

function lube.tcpClient:createSocket()
	self.socket = socket.tcp()
	self.socket:settimeout(0)
end

function lube.tcpClient:_connect()
	self.socket:settimeout(5)
	local success, err = self.socket:connect(self.host, self.port)
	self.socket:settimeout(0)
	return success, err
end

function lube.tcpClient:_disconnect()
	self.socket:shutdown()
end

function lube.tcpClient:_send(data)
	return self.socket:send(data)
end

function lube.tcpClient:_receive()
	local packet = ""
	local data, _, partial = self.socket:receive(8192)
	while data do
		packet = packet .. data
		data, _, partial = self.socket:receive(8192)
	end
	if not data and partial then
		packet = packet .. partial
	end
	if packet ~= "" then
		return packet
	end
	return nil, "No messages"
end

function lube.tcpClient:setoption(option, value)
	if option == "broadcast" then
		self.socket:setoption("broadcast", not not value)
	end
end

lube.tcpServer = class(lube.Server)
lube.tcpServer._implemented = true

function lube.tcpServer:createSocket()
	self._socks = {}
	self.socket = socket.tcp()
	self.socket:settimeout(0)
	self.socket:setoption("reuseaddr", true)
end

function lube.tcpServer:_listen()
	self.socket:bind("*", self.port)
	self.socket:listen(5)
end

function lube.tcpServer:send(data, clientid)
	-- This time, the clientip is the client socket.
	if clientid then
		clientid:send(data)
	else
		for sock, _ in pairs(self.clients) do
			sock:send(data)
		end
	end
end

function lube.tcpServer:receive()
	for sock, _ in pairs(self.clients) do
		local packet = ""
		local data, _, partial = sock:receive(8192)
		while data do
			packet = packet .. data
			data, _, partial = sock:receive(8192)
		end
		if not data and partial then
			packet = packet .. partial
		end
		if packet ~= "" then
			return packet, sock
		end
	end
	for i, sock in pairs(self._socks) do
		local data = sock:receive()
		if data then
			local hs, conn = data:match("^(.+)([%+%-])\n?$")
			if hs == self.handshake and conn ==  "+" then
				self._socks[i] = nil
				return data, sock
			end
		end
	end
	return nil, "No messages."
end

function lube.tcpServer:accept()
	local sock = self.socket:accept()
	while sock do
		sock:settimeout(0)
		self._socks[#self._socks+1] = sock
		sock = self.socket:accept()
	end
end