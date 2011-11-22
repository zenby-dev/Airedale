CurrentState = ""
CameraFocuses = {}

function SetState(s)

	CurrentState = s
	if not screens[s] then
	
		screens[s] = PhysicsScreen(10, 60)
		
	end
	
	if Levels[s] then Level = Levels[s] InitLevel(s) end
	
	if screen then
	
		screen.enabled = false --old screen disabled
	
	end
	
	screen = screens[s]
	screen.enabled = true

end

function GetState()

	return CurrentState

end

function StateIs(s)

	return GetState() == s

end

function SetCameraFocus(e, s)

	local s = s and s or GetState()
	CameraFocuses[s] = e

end

function GetCameraFocus(s)

	local s = s and s or GetState()
	return CameraFocuses[s]

end