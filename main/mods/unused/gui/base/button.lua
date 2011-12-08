GUI.Button = class(GUI.Box)

function GUI.Button:__init(x, y, w, h)

	self.super.__init(self, x, y, w, h)
	self.doclick = function() end
	self.dorclick = function() end
	self.dounclick = function() end
	self.dounrclick = function() end
	self.down = function() end
	self.pressed = false

end

function GUI.Button:DoClick(f)

	self.doclick = f

end

function GUI.Button:DoRightClick(f)

	self.dorclick = f

end

function GUI.Button:DoUnClick(f)

	self.dounclick = f

end

function GUI.Button:DoUnRightClick(f)

	self.dounrclick = f

end

function GUI.Button:Down(f)

	self.down = f

end

function GUI.Button:SetText(t)

	if self.label then self.label:Remove() self.label = nil end
	self.label = GUI.Label(3, 3)
	self.label:SetParent(self)
	self.label:SetText(t)
	self:SetSize(Vec2(#t * (fontsize / 2) + 5, self.size.y))

end