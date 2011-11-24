---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/21/11
-- Time: 11:50 PM
--

CLIENTKEYINPUT = {}
KEYS = loadtable(love.filesystem.read("config/keys.lua"))

hook.Add("Update", "SendInput.up", --TODO: Look into just iterating through the KeyConstant thing
function(dt)

	for k, v in pairs(KEYS) do --find held keys

		if love.keyboard.isDown(v) then CLIENTKEYINPUT[string.lower(v)] = true end

	end
	send("userinput", CLIENTKEYINPUT)
	CLIENTKEYINPUT = {}

end)

--[[hook.Add("KeyPressed", "SendInput.pr",
function(key)

	table.insert(CLIENTKEYINPUT, string.lower(key))

end)]]