---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/19/11
-- Time: 4:29 PM
--

function loadtable(text)

	local ret = loadstring(text)()
	--print("LOADED TABLE: "..ret)
	return ret

end

function tabletostring(t)

	local tab = "return\n"

	local function recurse(t, n)

		tab = tab.."{\n"
		local cc = 1

		local tl = 0

		for k, v in pairs(t) do

			tl = tl + 1

		end

		for k, v in pairs(t) do

			tab = tab..string.rep("\t", n)

			if type(k) == "string" then

				tab = tab.."[\""..k.."\"] = " --set up key

			end

			local vt = type(v)

			if vt == "table" and v.__type and v.__type == "Vec2" then

				tab = tab.."Vec2("..v.x..", "..v.y..")"

			elseif vt == "table" then

				recurse(v, n + 1)
				tab = tab..string.rep("\t", n).."}"

			elseif vt == "string" then

				tab = tab.."\""..v.."\""

			elseif vt == "number" or vt == "bool" then

				tab = tab..v

			end

			if cc ~= tl then
				tab = tab..","
			end
			tab = tab.."\n"

			cc = cc + 1

		end

	end

	recurse(t, 1)
	tab = tab.."}"
	return tab

end