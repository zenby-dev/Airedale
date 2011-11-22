keybinds = {} --ngngng nothing to see here

local function KeyBind(k, f) keybinds[k] = f end

function love.keypressed(key)
	
	if not textentry then
	
		if keybinds[key] then
			keybinds[key]()
		end
		hook.Call("KeyPressed", key)
	
	else
	
		if key == "return" then
			if textentry.text == "" then return end
			local t = textentry.text
			textentry.text = ""
			textentry.ef(t)
		elseif key == "escape" then
			textentry.es()
			textentry = nil
		elseif key == "backspace" then
			textentry:BackSpace()
		else
			if key ~= "lshift" then
				if love.keyboard.isDown("lshift") then
					if not textentry:Symbolt(key) then
						textentry:AddText(key:upper())
					else
						textentry:AddText(textentry:Symbolt(key))
					end
				else
					textentry:AddText(key)
				end
			end
		end
	
	end
	
end