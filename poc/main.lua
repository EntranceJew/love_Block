-- the address and port of the server
address, port = "localhost", 12345
entity = 0-- entity is what we'll be controlling
updaterate = 0.1 -- how long to wait, in seconds, before requesting an update
world = {} -- the empty world-state
t = 0
gamestate = 'main'

function love.load()
  math.randomseed(os.time())
  require("lube")
  require("network")  
  
  t = 0 -- (re)set t to 0
end

function love.update(dt)
  t = t + dt -- increase t by the deltatime
  if gamestate == 'main' then
    --if love.keyboard.isDown('h') then  launchServer(port) end
    --if love.keyboard.isDown('c') then  launchClient(tostring(math.random(99999)), address, port) end
  elseif gamestate == 'client' then
    if t > updaterate then
      local x, y = 0, 0
      if love.keyboard.isDown('up') then  y=y-(20*t) end
      if love.keyboard.isDown('down') then    y=y+(20*t) end
      if love.keyboard.isDown('left') then    x=x-(20*t) end
      if love.keyboard.isDown('right') then   x=x+(20*t) end
      client:send(string.format("%s %s %f %f", entity, 'move', x, y))
      client:send(string.format("%s %s $", entity, 'update'))
      
      t=t-updaterate -- set t for the next round
    end
    client:update(dt)
  elseif gamestate == 'server' then
    server:update(dt)
  end
end

function love.draw()
  for k, v in pairs(world) do
    love.graphics.print(k, v.x, v.y)
  end
end