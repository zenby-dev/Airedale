GUI = {} --ZenX2's super mostly useless GUI thing
GUI.Controls = {}

requiredir("/mods/gui/base")

hook.Add("Draw", "GUI_Draw", function()

	for k, v in pairs(GUI.Controls) do
	
		v:Draw()
	
	end

end)

hook.Add("MousePressed", "GUI_MousePressed", function(x, y, b)

	for k, v in pairs(GUI.Controls) do
	
		if (v.doclick or v.dorclick) and (x >= v.pos.x and x <= v.pos.x + v.size.x) and (y >= v.pos.y and y <= v.pos.y + v.size.y) then
		
			if b == "l" then
				
				v.doclick()
				v.pressed = b
				
			elseif b == "r" then
				
				v.dorclick()
				v.pressed = b
				
			end
		
		end
	
	end

end)

hook.Add("Update", "GUI_MouseDown", function()

	for k, v in pairs(GUI.Controls) do
	
		if v.pressed and v.down then
		
			v.down(Vec2(love.mouse.getPosition()), v.pressed)
		
		end
	
	end

end)

hook.Add("MouseReleased", "GUI_MouseReleased", function(x, y, b)

	for k, v in pairs(GUI.Controls) do
	
		if (v.dounclick or v.dounrclick) and v.pressed then
		
			if b == "l" then
				
				v.dounclick()
				v.pressed = false
				
			elseif b == "r" then
				
				v.dounrclick()
				v.pressed = false
				
			end
		
		end
	
	end

end)