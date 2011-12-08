GUI.Frame = class(GUI.Box)

function GUI.Frame:__init(x, y, w, h)

	self.super.__init(self, x, y, w, h)
	self.topbar = GUI.Button(0, 0, w, 20)
	self.topbar:Down(function(p, b)
		if b == "r" then return end
		self:SetPos(p)
	end)
	self.topbar:SetParent(self)
	self.closebutton = GUI.Button(w - 20, 0, 20, 20)
	self.closebutton:DoClick(function()
		self:Remove()
	end)
	self.closebutton:SetParent(self)
	function self.closebutton:Draw()
	
		self.super.Draw(self)
		SetColor(Color())
		local tx, ty, tw, th = self.pos.x, self.pos.y, self.size.x, self.size.y
		love.graphics.line(tx + 5, ty + 5, tx + tw - 5, ty + th - 5)
		love.graphics.line(tx + tw - 5, ty + 5, tx + 5, ty + th - 5)
	
	end

end

function GUI.Frame:NoCloseButton()

	self.closebutton:Remove()

end

function GUI.Frame:SetTitle(t)

	self.title = GUI.Label(3, 3)
	self.title:SetParent(self)
	self.title:SetText(t)

end

function FrameTest()
	frame = GUI.Frame(0, 0, 200, 300)
	frame:SetTitle("Hello")
	button = GUI.Button(40, 40, 30, 30)
	button:SetParent(frame)
	button:SetText("I'M A BUTTON!!!")
	button:DoClick(function() button:SetText(":P") end)
end