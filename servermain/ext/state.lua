CurrentState = ""
CameraFocuses = {}

function SetState(s)

	CurrentState = s

	ents = Ents[s] or {}
	
	if Levels[s] then Level = Levels[s] InitLevel(s) end

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