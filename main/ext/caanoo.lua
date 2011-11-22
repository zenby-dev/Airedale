--This gives some basic bits for getting the direction of a joystick

--[[
Caanoo nlove Joystick Buttons:
A = 0
B = 2
X = 1
Y = 3
R = 5
L = 4
HOME = 6
HELP1 = 8
HELP2 = 9
HOLD = 7
]]--

Joystick = {}

function Joystick.Up()
	if love.joystick.getAxis( 0, 1 ) == -1 then return true end
	return false
end

function Joystick.Down()
	if love.joystick.getAxis( 0, 1 ) == 1 then return true end
	return false
end

function Joystick.Left()
	if love.joystick.getAxis( 0, 0 ) == -1 then return true end
	return false
end

function Joystick.Right()
	if love.joystick.getAxis( 0, 0 ) == 1 then return true end
	return false
end