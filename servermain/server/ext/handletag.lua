---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/18/11
-- Time: 11:23 PM
--

HANDLERS = {}

function newhandler(tag, func)

	local function f(data, ci) --auto pcall

		local s, e = pcall(function() func(data, ci) end)
		if not s then error(e) end

	end
	HANDLERS[tag] = f

end

function handletag(inp, clientid)

	local t = inp:split("\1")
	local tag = t[1]
	local data
	if t[2] then
		data = loadtable(t[2])
	end
	if HANDLERS[tag] then

		HANDLERS[tag](data, clientid)

	end

end
