---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/21/11
-- Time: 8:41 PM
--

function AddClient(c)

	CLIENTS[c.ci] = c

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

function Client:Ban(reason, length)

	BANLIST[self.ci] = {reason, length, os.clock()} --start time
	self:Kick(reason)

end

function Client:Remove()

	CLIENTS[self.ci] = nil
	self = nil

end