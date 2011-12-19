local style = {}
local fonts = {}
fonts.default24 = love.graphics.newFont(24)
fonts.veramono12 = love.graphics.newFont('VeraMono.ttf', 12)
fonts.veramono18 = love.graphics.newFont('VeraMono.ttf', 18)
fonts.veramono24 = love.graphics.newFont('VeraMono.ttf', 24)
fonts.veramono32 = love.graphics.newFont('VeraMono.ttf', 32)

style['goo panel'] = {
	backgroundColor = {255,255,255},
	borderColor = {255,255,255},
	titleColor = {130,130,130},
	titleFont = fonts.veramono12,
	seperatorColor = {100,100,100}
}

style['goo close button'] = {
	color = {255,255,255},
	colorHover = {255,0,0}
}

style['goo button'] = {
	backgroundColor = {100,100,100},
	backgroundColorHover = {50,50,50},
	borderColor = {0,0,0,255},
	borderColorHover = {0,0,0},
	textColor = {200,200,200},
	textColorHover = {255,255,255},
	textFont = fonts.veramono18
}

style['goo big button'] = {
	buttonColor = {255,255,255,255},
	buttonColorHover = {200,150,255,255},
	textColor = {0,0,0,255},
	textColorHover = {0,0,0,255},
	font = {'VeraMono.ttf', 12}
}

style['goo text input'] = {
	borderColor = {0,0,0},
	backgroundColor = {255,255,255},
	textColor = {0,0,0},
	cursorColor = {0,0,0},
	cursorWidth = 2,
	borderWidth = 2,
	textFont = fonts.veramono12,
	blinkRate = 0.5,
	leading = 12
}

style['goo progressbar'] = {
	backgroundColor = {255,255,255},
	fillMode		= 'fill'
}

style['goo image'] = {
	imageTint = {255,255,255}
}

style['goo debug'] = {
	backgroundColor = {0,0,0,170},
	textColor = {255,255,255,255},
	textFont = fonts.veramono12
}

return style, fonts

