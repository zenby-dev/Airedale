---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/21/11
-- Time: 8:41 PM
--

function AddClient(c)

	CLIENTS[c.ci] = c

end

function GetClient(ci)

	if CLIENTS[ci] then

		return CLIENTS[ci]

	end

end

class.Client()

function Client:__init(ci)

	self.ci = ci --clientid, basically (%d.%d.%d.%d:%d, ip:port)
	self.name = ""

end

function Client:Kick(reason)

	disconnect(reason, self.ci)
	self:Remove()

end

function Client:Ban(reason, length) --TODO: implement bans (just block packets?)

	BANLIST[self.ci] = {reason, length, os.clock()} --start time
	self:Kick(reason)

end

function Client:Remove()

	CLIENTS[self.ci] = nil
	self = nil

end

function Client:GetIp()

	return self.ci:split(":")[1] --Just walk away.

end

newhandler("userinfo",
function(data, ci)

	if CLIENTS[ci] then

		CLIENTS[ci].name = data[1]

	end

end)