---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/18/11
-- Time: 11:29 PM
--

HANDLERS = {}

function newhandler(tag, func)

	local function f(data) --auto pcall

		local s, e = pcall(function() func(data) end)
		if not s then error(e) end

	end
	HANDLERS[tag] = f

end

function handletag(inp)

	local t = inp:split("\1") --separate tag
	local tag, data = t[1], loadtable(t[2]) --separate data into table
	if HANDLERS[tag] then

		HANDLERS[tag](data)

	end

end
