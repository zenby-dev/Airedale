env = {}
--[[----------------------------------------------------/
/-------------------------------------------------------/
/----------------------env.lua--------------------------/
/----------------------By ZenX2-------------------------/
/-------------------------------------------------------/
/-----This allows you to make unloadable lua files.-----/
/-----Yippee! just create a new environment, and--------/
/-----set it as the current in every file using it.-----/
/-------------------------------------------------------/
/------------------------------------------------------]]

function env.Create(e)
	local ne = {}
	local oe = _G
	setmetatable(ne, {__index = e or _G})
	return ne, oe
end

function env.Set(e, f)
	setfenv(f or 2, e)
end

function env.Unload(f)
	setfenv(f or 2, env.G)
end

function env.GetGlobal()

	return getfenv(2) --should return the normal global environment

end

env.G = env.GetGlobal() --shortcut!