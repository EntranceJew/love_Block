function love.load()
	
	tween = require("libraries.third-party.tween")
	require("libraries.loveframes")
	require("libraries.demo")
	
	bgimage = love.graphics.newImage("resources/images/bg.png")
   
end

function love.update(dt)

	loveframes.update(dt)
	tween.update(dt)
	
end

function love.draw()
	
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	local scalex = width/bgimage:getWidth()
	local scaley = height/bgimage:getHeight()
	
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(bgimage, 0, 0, 0, scalex, scaley)
	loveframes.draw()
	
end

function love.mousepressed(x, y, button)
	
	loveframes.mousepressed(x, y, button)
	
	local hoverobject = loveframes.hoverobject
	if hoverobject and hoverobject.menu_example and button == "r" then
		if hoverobject.menu then
			hoverobject.menu:Remove()
			hoverobject.menu = nil
		end
		createMenus(x, y)
	end
	
end

function love.mousereleased(x, y, button)

	loveframes.mousereleased(x, y, button)

end

function love.keypressed(key, unicode)
	
	loveframes.keypressed(key, unicode)
	
	if key == "f1" then
		local debug = loveframes.config["DEBUG"]
		loveframes.config["DEBUG"] = not debug
	elseif key == "f2" then
		loveframes.util.RemoveAll()
		demo.CreateToolbar()
		demo.CreateExamplesList()
	end
	
end

function love.keyreleased(key)

	loveframes.keyreleased(key)
	
end

if love._version == "0.9.1" then
	function love.textinput(text)
		loveframes.textinput(text)
	end
end