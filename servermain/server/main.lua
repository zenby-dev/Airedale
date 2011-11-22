love.filesystem.setIdentity("AiredaleServer")
requiredir("/server/ext")
requiredir("/server/ents")
requiredir("/server/handlers")

function GameHooks.Init()
	
	--GAME VARIABLES
	pause = false

	--love.mouse.setVisible(false) --grabbing and changing the mouse
	--love.mouse.setGrab(true)
	--CursorImage = Image("game/sprites/crosshair.png", Vec2(love.mouse.getPosition()))
	--CursorImage:SetOrigin(Vec2(16, 16))

	CameraPos = Vec2(0, 0) --the position of the camera (IMPORTANT!!!!)

	love.graphics.setBackgroundColor(34, 34, 34)

	CONFIG = loadtable(love.filesystem.read("config/config.lua"))

	CLIENTS = {}
	SERVER = lube.udpServer()
	SERVER.handshake = "AIREDALEHANDSHAKE"
	function SERVER.callbacks.recv(data, clientid)

		handletag(tostring(data), tostring(clientid))
		--SERVER:send(data, clientid)

	end
	function SERVER.callbacks.connect(clientid)

		if table.size(SERVER.clients) > CONFIG.maxplayers then

			disconnect("Sorry, this server is full.", clientid)
			return

		end

		AddClient(Client(clientid))

	end
	function SERVER.callbacks.disconnect(clientid)

		local c = GetClient(clientid)
		print(c.name.." ("..clientid..")".." has disconnected.")
		send("print", {c.name.." ("..clientid..")".." has disconnected."})
		RemoveClient(clientid)

	end
	SERVER:setPing(true, 30, "AIREDALEPING") --30 seconds of leniency.
	SERVER:listen(CONFIG.PORT)

	include("server/game/main.lua")

	print("Airedale Server, now running on port "..CONFIG.PORT)
	print("Use |INSERT GAME SELECTION FUNCTION WHEN DONE| to select the game for the server to run.")
	print("Or just sit there. It'll be all sandboxy/chat servery.")

end

--Menu.Main() --If you want to use my menu system, go ahead
--Menu.Open = true

function Pause(b) --functioning pausing, can change window title

	pause = b
	
	if b then
	
		love.graphics.setCaption("PAUSED, YO")
		
	else
	
		love.graphics.setCaption("UNPAUSED, YO")
		
	end

end

function GameHooks.Update(dt) --default update

	--CursorImage:SetPos(Vec2(love.mouse.getPosition()))

	SERVER:update(dt)

	if pause then return end --necissary for pausing
	
	--Update stuff

end

function GameHooks.Draw() --default draw

	local g = love.graphics --wheee

	g.push()
	
	g.translate(-CameraPos.x, -CameraPos.y) --should be with all world elements
	
	--if background then background:Draw() end --draw a background yes maybe?
	
	--draw stuff
	
	g.pop()
	
	--hook.Call("DrawGUI") --if you want it to draw at a specified point
	
	if pause and not Menu.OnMainMenu then --a kewl pause notificator
	
		love.graphics.setFont(Menu.LFont)
		love.graphics.print("Paused!", 5, 5)
		
	end
	
	--CursorImage:Draw() --Should be last to draw, if you're using it

end

hook.Add("KeyPressed", "Do menu stuff", function(key) --love.KeyPressed or whatever

	if key ~= "escape" then return end --only if you are pressing esc
	
	--[[if not Menu.Open then
	
		Menu.InGame()
		Menu.Open = true
		Pause(true)
	
	elseif not Menu.OnMainMenu then
	
		Menu.Clear()
		Menu.Open = false
		Pause(false)
	
	end]]

end)

--[[hook.Add("Draw", "DrawTextEntry", function() --if you're using my text entry thingies

	for k, v in pairs(TextEntries) do
	
		v:Draw()
	
	end

end)]]