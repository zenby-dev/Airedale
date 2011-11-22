class.Menu()

function Menu:__init(title, c)

	self.close = c or true
	self.title = title or "Menu"
	self.optionst = {}
	self.cs = 1
	self.options = ""
	self.s = ">"
	self.open = function() end

end

function Menu:FillFunc(f)

	self.fill = f

end

function Menu:Fill()

	self.optionst = {}
	local ocs = self.cs
	self.cs = 1
	self.s = ">"
	self.options = ""
	self.fill()
	--if self.optionst[osc] then
		for i = 1, ocs - 1 do
			self:MoveDown()
		end
	--end

end

function Menu:Add(n, f)

	
	self.options = ""
	
	for i = #self.optionst, 1, -1  do
	
		self.options = self.optionst[i][1].."\n"..self.options
	
	end
	
	self.options = self.options..n
	
	table.insert(self.optionst, {n, f})

end

function Menu:Remove(i)

	
	self.optionst[i] = nil
	
	self.options = ""
	
	for i = #self.optionst, 1, -1  do
	
		self.options = self.optionst[i][1].."\n"..self.options
	
	end
	
	self.options = self.options..n

end

function table.size(t)

	local n = 0
	for k, v in pairs(t) do
	
		n = n + 1
	
	end
	return n

end

function Menu:MoveDown()

	if self.cs + 1 <= table.size(self.optionst) then
	
		self.cs = self.cs + 1
		self.s = ">"
		for i = 1, self.cs - 1 do
		
			self.s = "\n"..self.s
		
		end
		
	end

end

function Menu:MoveUp()

	if self.cs - 1 > 0 then
	
		self.cs = self.cs - 1
		self.s = ">"
		for i = 1, self.cs - 1 do
		
			self.s = "\n"..self.s
		
		end
		
	end

end

function Menu:DoChoice()

	self.optionst[self.cs][2]()

end

function Menu:GoBack()

	local go, n = false
	for k, v in pairs(self.optionst) do
	
		if v[1] == "Back" then go = true n = k break end
	
	end
	
	if go then
		self.optionst[n][2]()
	end

end

function Menu:OnOpen(f)

	self.open = f

end

function Menu:Draw()

	love.graphics.setFont(lfont)
	love.graphics.print(self.title, 10, 0)
	love.graphics.setFont(sfont)
	love.graphics.print(self.options, 25, 30)
	love.graphics.print(self.s, 15, 30)

end

function SetMenu(m)

	menuopen = true
	menu = m --ahahahahh
	if m.fill then m:Fill() end
	if m.open then m.open() end

end

function ToggleMenu(p)

	if menu.close == true then menuopen = p end

end

function GotoMainMenu()

	SetMenu(menus.root)
	menuopen = false

end

class.TextMenu(Menu)

function TextMenu:__init(title)

	self.super.__init(self, title, false)
	self.close = false
	self.text = ""

end

function TextMenu:SetText(t)

	self.text = t

end

function TextMenu:Draw()

	love.graphics.setFont(lfont)
	love.graphics.print(self.title or "DERP", 10, 0)
	love.graphics.setFont(sfont)
	love.graphics.print(self.options or "DERP", 25, h - 175)
	love.graphics.print(self.s or "DERP", 15, h - 175)
	love.graphics.printf(self.text or "DERP", 15, 25, love.graphics.getWidth() - 35)

end