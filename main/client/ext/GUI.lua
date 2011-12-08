---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 12/7/11
-- Time: 7:34 PM
--

-----------------------
--Simple GUI drawing.--
-----------------------

GUI = {}

GUI.DrawFuncs = {}

GUI.elements = {}

function GUI.Remove(k)

	GUI.elements[k] = nil

end

function GUI.Clear()

	GUI.elements = {}

end

function GUI.AddText(key, text, x, y)

	GUI.elements[key] = {"text", {text, x, y}}

end

function GUI.Draw()

	for k, v in pairs(GUI.elements) do

		GUI.DrawFuncs[v[1]](unpack(v[2]))

	end

end

GUI.DrawFuncs["text"] = function(t, x, y)

	love.graphics.print(t, x, y)

end