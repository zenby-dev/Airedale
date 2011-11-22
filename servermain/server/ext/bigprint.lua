---
-- Created by IntelliJ IDEA.
-- User: ZenX2
-- Date: 11/17/11
-- Time: 7:30 PM
--

local LETTERS = {}
--[[LETTERS[""] =
	{
		"",
		""
	}]]

LETTERS[" "] =
	{
		"  ",
		"  "
	}

LETTERS["a"] =
	{
		" /_\\ ",
		"/   \\"
	}

LETTERS["b"] =
	{
		"|_)",
		"|_)"
	}

LETTERS["c"] =
	{
		"/'",
		"\\,"
	}

LETTERS["d"] =
	{
		"| \\",
		"|_/"
	}

LETTERS["e"] =
	{
		"/_\\",
		"\\_ "
	}

LETTERS["f"] =
	{
		"|``",
		"|` "
	}

LETTERS["g"] =
	{
		" (_)",
		"  _/"
	}

LETTERS["h"] =
	{
		"|_|",
		"| |"
	}

LETTERS["i"] =
	{
		"|",
		"|"
	}

LETTERS["j"] =
	{
		" `|`",
		"\\_/ "
	}

LETTERS["k"] =
	{
		"|_/",
		"| \\"
	}

LETTERS["l"] =
	{
		"| ",
		"|_"
	}

LETTERS["m"] =
	{
		"|\\/|",
		"|  |"
	}

LETTERS["n"] =
	{
		"|\\ |",
		"| \\|"
	}

LETTERS["o"] =
	{
		"/\\",
		"\\/"
	}

LETTERS["p"] =
	{
		"|_)",
		"|  "
	}

LETTERS["q"] =
	{
		"/\\",
		"\\X"
	}

LETTERS["r"] =
	{
		"|_)",
		"| \\"
	}

LETTERS["s"] =
	{
		"/_",
		" /"
	}

LETTERS["t"] =
	{
		"--|--",
		"  |  "
	}

LETTERS["u"] =
	{
		"|   |",
		" \\_/ "
	}

LETTERS["v"] =
	{
		"\\  /",
		" \\/ "
	}

LETTERS["w"] =
	{
		"\\  /\\  /",
		" \\/  \\/ "
	}

LETTERS["x"] =
	{
		"\\/",
		"/\\"
	}

LETTERS["y"] =
	{
		"\\ /",
		" | "
	}

LETTERS["z"] =
	{
		"`/",
		"/_"
	}

LETTERS[","] =
	{
		" ",
		"/"
	}

LETTERS[":"] =
	{
		".",
		"."
	}

LETTERS[";"] =
	{
		".",
		"/"
	}

LETTERS["!"] =
	{
		"|",
		"."
	}

LETTERS["?"] =
	{
		"/\\",
		" !"
	}

LETTERS["/"] =
	{
		" /",
		"/ "
	}

LETTERS["\\"] =
	{
		"\\ ",
		" \\"
	}

LETTERS["|"] =
	{
		"|",
		"|"
	}

function bigprint(...)

	local line1 = ""
	local line2 = ""
	for _, v in pairs({...}) do

		local v = string.lower(tostring(v))
		for i = 1, #v do
			local s = string.sub(v, i, i)
			if LETTERS[s] then
				line1 = line1..LETTERS[s][1].." "
			end
		end

	end

	for _, v in pairs({...}) do

		local v = string.lower(tostring(v))
		for i = 1, #v do
			local s = string.sub(v, i, i)
			if LETTERS[s] then
				line2 = line2..LETTERS[s][2].." "
			end
		end

	end

	print(line1)
	print(line2)

end
