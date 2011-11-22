--The files in the autorun folder are automatically loaded.
--The main.lua in every folder is loaded
requiredir("/mods/autorun")

for k, v in pairs(love.filesystem.enumerate("/mods")) do
	
	if love.filesystem.isDirectory("/mods/"..v) and v ~= "autorun" and v ~= "unused" then
		require("/mods/"..v.."/main")
	end
	
end
