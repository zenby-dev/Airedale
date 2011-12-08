GUI.Label = class(GUI.Box)

function GUI.Label:__init(x, y)

	self.super.__init(self, x, y)
	self.text = ""

end

function GUI.Label:Draw()

	love.graphics.print(self.text, self.pos.x, self.pos.y)

end

function GUI.Label:SetText(t)

	self.text = t

end