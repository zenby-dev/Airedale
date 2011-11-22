class.TextEntry(ListElem) --Text entry class. dangerous territory

TextEntries = {}

function TextEntry:__init(p)

	self.pos = p
	self.text = ""
	self.ef = function() end
	self.es = function() end
	self.selected = false
	
	ListElem.__init(self, TextEntries)

end

function TextEntry:Text()

	return self.text

end

TextEntry.acceptable = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ",", ".", "/", "!", "?", "\"", "'", ";", ":", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "_", "+", "=", "[", "]", "{", "}", " "}
TextEntry.symbolt = {{"/", "?"}, {";", ":"}, {"'", "\""}, {"1", "!"}, {"2", "@"}, {"3", "#"}, {"4", "$"}, {"5", "%"}, {"6", "^"}, {"7", "&"}, {"8", "*"}, {"9", "("}, {"0", ")"}, {"-", "_"}, {"=", "+"}, {"[", "{"}, {"]", "}"}}

function TextEntry:Symbolt(key)

	for k, v in pairs(self.symbolt) do
	
		if v[1] == key then return v[2] end
	
	end

end

function TextEntry:AddText(t)

	if not table.HasValue(self.acceptable, t:lower()) then return end
	t = t or ""
	self.text = self.text..t

end

function TextEntry:BackSpace()

	self.text = string.sub(self.text, 1, #self.text - 1) or ""

end

function TextEntry:Clear()

	self.text = ""

end

function TextEntry:EnterFunc(f)

	self.ef = f

end

function TextEntry:Draw()

	self.text = self.text or ""
	love.graphics.setFont(sfont)
	if self.selected then
		love.graphics.print(self.text.."_" or "", self.pos.x, self.pos.y)
	else
		love.graphics.print(self.text or "", self.pos.x, self.pos.y)
	end

end

function SetTextEntry(t)

	if textentry then 
		textentry.selected = false
	end
	
	textentry = t
	
	if not textentry then return end
	
	textentry.selected = true

end