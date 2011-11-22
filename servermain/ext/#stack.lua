class.Stack()

function Stack:__init(t)

	self.t = t or {}

end

function Stack:Push(v)

	self.t[#self.t + 1] = v --v is the new top value

end

function Stack:Pop()

	local v = self.t[#self.t] --grab the top value
	self.t[#self.t] = nil --destroy the top index
	return v --return the value

end

function Stack:Peek()

	return self.t[#self.t] --get the top value

end

function Stack:Shove(a)

	local tmp = self.t
	self.t = {}
	self.t[1] = a
	for k, v in pairs(tmp) do
	
		self.t[#self.t + 1] = v
	
	end

end

function Stack:Pull()

	local val = self.t[1]
	self.t[1] = nil
	local tmp = self.t
	self.t = {}
	for k, v in pairs(tmp) do
	
		self.t[#self.t + 1] = v
	
	end
	return val

end

function Stack:Lift()

	return self.t[1]

end

function Stack:Get()

	return self.t

end