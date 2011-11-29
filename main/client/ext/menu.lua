---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/28/11
-- Time: 5:43 PM
--

Menu = {} --ZenX2's menu class. again, dangerous.

Menu.Buttons = {} --Buttons
Menu.Images = {} --Images
Menu.LastOption = nil

Menu.LFont = love.graphics.newFont('VeraMono.ttf', 18)

Menu.Open = false --Is a menu open?
Menu.OnMainMenu = false --is it the main menu?

function Menu.Button(p, t, f) --create a button

	table.insert(Menu.Buttons, {p, t, f})

end

function Menu.Image(p, pa)

	local im = Image(pa, p)
	table.insert(Menu.Images, im)

end

function Menu.Clear() --no moar buttons

	Menu.Buttons = {}
	for k, v in pairs(Menu.Images) do

		v:Remove()

	end
	Menu.Buttons = {}
	Menu.Images = {}

end

local function Draw()

	if not Menu.Open then return end

	love.graphics.setFont(Menu.LFont)
	for k, v in pairs(Menu.Buttons) do

		local x, y = love.mouse.getPosition()

		if x >= v[1].x and x <= v[1].x + 300 and y >= v[1].y and y <= v[1].y + 18 then

			love.graphics.setColor(255, 255, 255, 255)

		else

			love.graphics.setColor(255, 255, 255, 150)

		end

		love.graphics.print(v[2], v[1].x, v[1].y)

	end

	love.graphics.setColor(255, 255, 255, 255)

end

--[[Menu.Levels = {} --I use this for TopWise

for k, v in pairs(love.filesystem.enumerate("/game/maps")) do
	if love.filesystem.isFile("/game/maps/"..v) and string.sub(v, -4, -1) == ".xml" then
		table.insert(Menu.Levels, "game/maps/"..v)
	end
end]]

--[[local function Draw() --draw, I don't know why it isn't in the hook definition

	if not Menu.Open then return end

	love.graphics.setFont(Menu.LFont)
	for k, v in pairs(Menu.Buttons) do

		local x, y = love.mouse.getPosition()

		if x >= v[1].x and x <= v[1].x + 300 and y >= v[1].y and y <= v[1].y + 18 then

			love.graphics.setColor(255, 255, 255, 255)

		else

			love.graphics.setColor(255, 255, 255, 150)

		end

		love.graphics.print(v[2], v[1].x, v[1].y)

	end

	love.graphics.setColor(255, 255, 255, 255)

end]]

function Menu.Main() -- the main menu for TopWise-ish

	Menu.OnMainMenu = true
	Menu.Clear()
	disconnect()

	--[[Menu.Button(Vec2(), "", function()



	end)]]

	--Menu.Image(Vec2(350, 40), "resources/polycode_logo.png")

	Menu.Button(Vec2(40, 240), "Connect to localhost", function()

		Menu.Clear()
		Menu.Open = false
		Menu.OnMainMenu = false
		LHC()

	end)

	--[[Menu.Button(Vec2(40, 360), "Options", function()



	end)]]

	Menu.Button(Vec2(40, 525), "Exit", function()

		love.event.push("q")

	end)

end

function Menu.InGame() --the ingame version of the menu

	Menu.Clear()

	--[[Menu.Button(Vec2(), "", function()



	end)]]

	--[[Menu.Button(Vec2(40, 240), "Load Map", function()

		Menu.LevelLoader(1)

	end)]]

	--[[Menu.Button(Vec2(40, 360), "Options", function()



	end)]]

	Menu.Button(Vec2(40, 525), "Main Menu", function()

		disconnect()
		love.load() --this basically resets the game.
		--Menu.Main()

	end)

end

--[[function Menu.LevelLoader(n, m) --my implementaion of a multi page menu

	Menu.Clear()

	for i = 0, 4 do

		if Menu.Levels[n + i] then

			local name, desc, gamemode = LevelInfo(Menu.Levels[n + i])

			Menu.Button(Vec2(40, 180 + (40 * i)), name.." - "..desc, function()

				local function levelopt()

					Menu.Clear()

					local gmte = TextEntry(Vec2(40, 300))
					gmte:EnterFunc(function(txt)

						gamemode = txt
						SetTextEntry(nil)
						levelopt()

					end)

					Menu.Button(Vec2(40, 260), "Game Mode: "..gamemode, function()

						SetTextEntry(gmte)

					end)

					Menu.Button(Vec2(40, 340), "Play", function()

						LoadMapFromXML(Menu.Levels[n + i], gamemode)
						Menu.Clear()
						Menu.Open = false
						Menu.OnMainMenu = false
						Pause(false)
						SetTextEntry(nil)

					end)

					Menu.Button(Vec2(40, 380), "Back", function()

						Menu.LevelLoader(n, m)
						SetTextEntry(nil)

					end)

				end

				levelopt()

			end)

		end

	end

	if #Menu.Levels > n + 4 then

		Menu.Button(Vec2(40, 380), "-->", function()

			Menu.LevelLoader(n + 1, m)

		end)

	end

	if n - 1 > 0 then

		Menu.Button(Vec2(40, 140), "<--", function()

			Menu.LevelLoader(n - 1, m)

		end)

	end

	if m then

		Menu.Button(Vec2(40, 100), "Back", function()

			include("game/main.lua")
			Menu.Main()

		end)

	else

		Menu.Button(Vec2(40, 100), "Back", function()

			Menu.InGame()

		end)

	end

end]]

hook.Add("MouseReleased", "DoMenu", function(x, y, b)

	if not Menu.Open then return end

	local mp = Vec2(x, y)

	for k, v in pairs(Menu.Buttons) do

		if x >= v[1].x and x <= v[1].x + 300 and y >= v[1].y and y <= v[1].y + 18 and b == "l" then

			v[3]()

		end
	end

end)

hook.Add("KeyPressed", "toggleingamemenu",
function(key)

	if key == "escape" and Menu.OnMainMenu == false then

		Menu.InGame()
		Menu.Open = not Menu.Open

	end

end)

hook.Add("Draw", "DrawMenu", Draw)