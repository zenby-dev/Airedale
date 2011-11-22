hook = {}

GameHooks = {}
hooks = {}
statehooks = {}

function hook.Call(name, ...)

	local ret = {}
	if GameHooks[name] then
		local re = GameHooks[name](...)
		if re then
			table.insert(ret, re)
		end
	end
	for k, v in pairs((hooks[name] or {})) do
	
		local re = v(...)
		
		if re then
			table.insert(ret, re)
		end
	
	end
	if statehooks[GetState()] then
		for k, v in pairs((statehooks[GetState()][name] or {})) do
		
			local re = v(...)
			
			if re then
				table.insert(ret, re)
			end
		
		end
	end
	return ret

end

function hook.Add(h, u, f, s)

	if not s then
		if not hooks[h] then hooks[h] = {} end
		hooks[h][u] = f
	else
		if not statehooks[s] then statehooks[s] = {} end
		if not statehooks[s][h] then statehooks[s][h] = {} end
		statehooks[s][h][u] = f
	end

end

function hook.Remove(h, u, s)

	if not s then
		hooks[h][u] = nil
	else
		statehooks[s][h][u] = nil
	end

end

function hook.Clear(h, s)

	if not s then
		hooks[h] = nil
	else
		statehooks[s][h] = nil
	end

end

function hook.ClearAll(s)

	if not s then
		for k, v in pairs(hooks) do
		
			hook.Clear(k)
		
		end
	else
		for k, v in pairs(statehooks[s]) do
		
			hook.Clear(k, s)
		
		end
	end

end

--hook.Call("", ) --name, args