world = {} -- the empty world-state

function love.load()
  require("lube")
  require("network")
end

function love.update(dt)
  server:update(dt)
end

function love.draw()
  for k, v in pairs(world) do
    love.graphics.print(k, v.x, v.y)
  end
end