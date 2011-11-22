ckeybinds = {} --Stuff for Caanoo development

function CKeyBind(k, f) ckeybinds[k] = f end

CKeyBind("home", function() love.event.push("q") end)

local translate = {}
translate[0] = "A"
translate[2] = "B"
translate[1] = "X"
translate[3] = "Y"
translate[5] = "R"
translate[4] = "L"
translate[6] = "HOME"
translate[8] = "HELP1"
translate[9] = "HELP2"
translate[7] = "HOLD"

local translate2 = {}
translate2["A"] = 0
translate2["B"] = 2
translate2["X"] = 1
translate2["Y"] = 3
translate2["R"] = 5
translate2["L"] = 4
translate2["HOME"] = 6
translate2["HELP1"] = 8
translate2["HELP2"] = 9
translate2["HOLD"] = 7

function love.joystickpressed(_, b)
	
	if translate[b] and ckeybinds[translate[b]:lower()] then
		ckeybinds[translate[b]:lower()]()
	end
	hook.Call("ButtonPressed", b)
	
end

hook.Add("Update", "JoystickMoved", function(dt)
	
	if Joystick.Up() then
		if ckeybinds["up"] then
			ckeybinds["up"](dt)
		end
	elseif Joystick.Down() then
		if ckeybinds["down"] then
			ckeybinds["down"](dt)
		end
	elseif Joystick.Left() then
		if ckeybinds["left"] then 
			ckeybinds["left"](dt)
		end
	elseif Joystick.Right() then
		if ckeybinds["right"] then
			ckeybinds["right"](dt)
		end
	end
	hook.Call("JoystickMoved", dt)
	
end)

local oldid = love.joystick.isDown

function love.joystick.isDown(j, b)

	if not translate2[b:upper()] then return false end
	return oldid(j, translate2[b:upper()])

end