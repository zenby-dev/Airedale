-- simple single-inheritence class mechanism
--With improvements by ZenX2

local Object -- base of the class heirarchy (forward reference)

local function new(class, ...)
   local instance = setmetatable({}, class)
   instance:__init(...)
   return instance
end

class = {}
local mt = {}
setmetatable(class, mt)

function mt:__call(super)
	super = super or Object
	local prototype = setmetatable({}, super)
	if not super then super = {} end
	if not super.__children then super.__children = {} end
	table.insert(super.__children, prototype)
	prototype.super = super
	prototype.__index = prototype
	prototype.__call = new
	return prototype
end

function mt:__index(name)
	return function(...)
		local c = class(...)
		getfenv()[name] = c
		c.__classname = name
		return c
	end
end

Object = class()

function Object:__init() -- so you can always safely call super.__init
end

function Object:instance_of(class)
   return getmetatable(self) == class
end

function Object:__getclass()
   return getmetatable(self)
end

function Object:subclass_of(class)
   repeat
      self = getmetatable(self)
      if self == class then return true end
   until not self
end


--[[ Usage example:
   Foo = class()            -- subclass Object
   function Foo:__init(x,y) -- optional constructor
       self.x, self.y = x, y
   end
   function Foo:report() 
      print(self.x, self.y)
   end
   Bar = class(Foo) -- subclass Foo
   b = Bar(10,20)   -- create Bar instance, calls Foo:__init
   b:report()       -- 10,20

   Zip = class(Bar)
   function Zip:__init(x,y,z)       -- override Foo constructor
      self.super.__init(self, x, y) -- call up the inheritence chain
      self.z = z
   end

   z = Zip(4,5,6)
   assert(    z:instance_of(Zip))
   assert(not z:instance_of(Bar))
   assert(    z:subclass_of(Bar))
   assert(    z:subclass_of(Foo))
--]]
