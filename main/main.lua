local _print = print
local Console = require "console"
console = nil
input   = nil
output  = nil

local console_active = false

function ConsoleOpen(b)

	console_active = b

end

local debug = debug
local function error_handler(msg)
	print((debug.traceback("Error: " .. msg, 4):gsub("\t", "    ")))
end

local handler_names = {
	kr = 'keyreleased',
	mp = 'mousepressed',
	mr = 'mousereleased',
	jp = 'joystickpressed',
	jr = 'joystickreleased',
	f = 'focus',
}

function love.run()
	local LOADWIN, LOADERROR = xpcall(love.load, error_handler)
	--if not LOADWIN then print(LOADERROR) end

	love.keyboard.setKeyRepeat(150, 50)
	love.graphics.setBackgroundColor(34,34,34)
	local font = love.graphics.newFont('VeraMono.ttf', 14)
	console = Console.new(font)

	print("|  '/\\'\\  / /_\\  __  /' /\\ |\\ | /_ /\\ |   /_\\")
	print("|__ \\/  \\/  \\_       \\, \\/ | \\|  / \\/ |__ \\_   (v.1e-127)")
	print()
	print("<Escape> toggles the console. Call quit() or exit() to quit.")
	print("Try hitting <Tab> to complete your current input.")
	print("You can overwrite every love callback.")
	print()
	
	if love.load then xpcall(function() love.load(arg) end, error_handler) end

	local dt = 0

	-- Main loop time.
	while true do
		if love.timer then
			love.timer.step()
			dt = love.timer.getDelta()
		end
		if love.update then if not xpcall(function() love.update(dt) end, error_handler) then love.update = nil end end -- will pass 0 if love.timer is disabled
		if love.graphics then
			love.graphics.clear()
			if love.draw then if not xpcall(function() love.draw() end, error_handler) then love.draw = nil end end
			
			if console_active then
				love.graphics.setScissor(2,2, love.graphics.getWidth()-4, love.graphics.getHeight()-4)
				local color = {love.graphics.getColor()}
				love.graphics.setColor(34,34,34,180)
				love.graphics.rectangle('fill', 2,2, love.graphics.getWidth()-4, love.graphics.getHeight()-4)
				love.graphics.setColor(221,221,221)
				console:draw(4, love.graphics.getHeight() - 4)
				love.graphics.setColor(unpack(color))
				love.graphics.setScissor(0, 0, love.graphics.getWidth(), love.graphics.getHeight())
			end
		end

		-- Process events.
		if love.event then
			for e,a,b,c in love.event.poll() do
				if e == "q" then
					if CONNECTED then disconnect() end
					if not love.quit or not love.quit() then
						if love.audio then
							love.audio.stop()
						end
						return
					end
				elseif e == "kp" then
					--[[if love.keypressed then
						-- if exists, call love.draw. on error, remove function
						if not xpcall(function() love.keypressed(a, b) end, error_handler) then
							love.keypressed = nil
						end
					end]]
					
					if a == 'f1' then
						console_active = not console_active
					end

					if console_active then
						console:keypressed(a,b)
					end
				end
				love.handlers[e](a,b,c)
			end
		end

		if love.timer then love.timer.sleep(0.001) end
		if love.graphics then love.graphics.present() end

	end
end

function print(...)
	return console:print(...)
end

function printf(fmt, ...)
	return print(string.format(fmt, ...))
end

function quit()
	love.event.push('q')
end
exit = quit

function love.load() --LEF loading
	math.randomseed(os.time()) --Set up a random seed
	math.random() math.random() math.random() --toss the salad
	require("conf") --load conf

	require("socket") print()
	require("LUBE") print("Networking stuff loaded.")

	function include(dir) --Not much slower, allows for re-loading of files.
	
		local s, e = pcall(love.filesystem.load(dir)) --safety.
		if not s then error(e) end
		return e
	
	end
	
	local olr = require
	function require(f)
	
		if string.sub(f, -4, -1) == ".lua" then
		
			olr(string.sub(f, 1, -5))
			
		else
		
			olr(f)
			
		end
	
	end
	
	function requiredir(dir) --spacesaver 9000

		for k, v in pairs(love.filesystem.enumerate(dir)) do
			if love.filesystem.isFile(dir.."/"..v) then
				include(dir.."/"..v)
			end
		end

	end

	goo = include("goo/goo.lua")
	goo:load()
	goo:setSkin("airedale")

	requiredir("/ext") --load them extensions
	require("mods/loader.lua") --load mods
	
	ents = {} --ents.
	fontsize = 12 --the basic font size
	sfont = love.graphics.newFont('VeraMono.ttf', fontsize) --basic font

	CONFIG = loadtable(love.filesystem.read("config/config.lua")) --EARLY

	if CONFIG.FULLSCR then

		love.graphics.setMode(0, 0, true)

	else

		love.graphics.setMode((CONFIG.SCRW or 320), (CONFIG.SCRH or 240), false)

	end

	--love.mouse.setVisible(false)

	love.keyboard.setKeyRepeat(150, 50)
	
	include("client/main.lua") --load the game

	hook.Call("Init") --call init
end

function love.update(dt) --update wrapper

	goo:update(dt)

	ParticleSys.Update() --update particle system wrapper
	
	hook.Call("Update", dt) --call update

end

function SetColor(c) --set color using my color class

	love.graphics.setColor(c.r, c.g, c.b, c.a)

end

function love.draw()

	local g = love.graphics

	g.push()

	hook.Call("Draw") --call draw

	hook.Call("DrawGUI")

	g.setFont(Menu.LFont)

	--g.print("\\", love.mouse.getX(), love.mouse.getY())

	g.pop()

	goo:draw()

end

function love.mousepressed(x, y, b) --and more wrappers. whee

	hook.Call("MousePressed", x, y, b)
	local s, e = pcall(function() goo:mousepressed(x, y, b) end)
	if not s then print("Error: "..e) end

end

function love.mousereleased(x, y, b)

	hook.Call("MouseReleased", x, y, b)
	local s, e = pcall(function() goo:mousereleased(x, y, b) end)
	if not s then love.filesystem.write("ERRORRRRR NOES.txt", e) end

end

function love.focus(f)

	hook.Call("Focus", f)

end

function love.keypressed(key, uni)

	hook.Call("KeyPressed", key)
	local s, e = pcall(function() goo:keypressed(key, uni) end)
	if not s then print("Error: "..e) end

end

function love.keyreleased(key, uni)

	hook.Call("KeyReleased", key)
	local s, e = pcall(function() goo:keyreleased(key, uni) end)
	if not s then print("Error: "..e) end

end