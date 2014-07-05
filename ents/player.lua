Player = class('Player')
local identifier = 'players'
function Player:initialize(name, x, y)
  self.active = true
  self.visible = true
  self.world = game.world
  self.world_id = #self.world[identifier]+1
  self.name = name
  self.x = x
  self.y = y
  
  self.binds = TLbind.giveInstance({keys=keys})
  
  local font = love.graphics.getFont()
  self.width = font:getWidth(self.name)
  self.height = font:getHeight()
  self.ox, self.oy = self.width/2, self.height/2
  
  
  self.rotation = 0
  self.spin_speed = 0.122173048
  
  self.net_history = {}
  -- keyed by tick number
  
  self.speed = 200 -- MYSTERY UNITS~
  self.world[identifier][self.world_id] = self
  return self
end

function Player:network_proxy(command, parameters)
  -- Add a command to the network stack and execute it.
  if type(self.net_history[game.net.tick])~="table" then
    self.net_history[game.net.tick]={}
  end
  table.insert(self.net_history[game.net.tick],{time=love.timer.getTime(), cmd=command, params=parameters})
  self[command](self,unpack(parameters))
end

function Player:network_action(tick, time, command, parameters)
  if type(self.net_history[tick])~="table" then
    self.net_history[tick]={}
  end
  table.insert(self.net_history[tick],{time=time, cmd=command, params=parameters})
end

function Player:replay_from_tick(tick)
  -- shit I don't need any smangy code for now
  for i=tick, #self.net_history do
    da = self.net_history[i][1]
    self[da.cmd](self,unpack(da.params))
  end
end

function Player:update(dt)
  self.binds:update()
  local x, y = 0, 0
  if self.binds.control.north then      y=y-1 end
  if self.binds.control.south then    y=y+1  end
  if self.binds.control.west then    x=x-1 end
  if self.binds.control.east then   x=x+1  end
  
  self:network_proxy('altMove', {x,y,dt})
  
  self.rotation = self.rotation + dt*self.spin_speed
  
  if self.rotation >= 6.28318531 then
    self.rotation = self.rotation - 6.28318531
  end
end

function Player:setControls(binds)
  self.binds = TLbind.giveInstance(binds)
end

function Player:draw()
  -- bounding circle
  love.graphics.setColor(0, 255, 0, 255)
  love.graphics.circle( "fill", self.x, self.y, self.width/2, 100 )
  
  -- text
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.print(self.name, self.x, self.y, self.rotation, 1, 1, self.ox, self.oy)
  
  -- point of rotation
  love.graphics.setColor(255, 0, 0, 255)
  love.graphics.circle( "fill", self.x, self.y, 1, 100 )
end

function Player:at(x, y)
  -- used mainly for local server/client repositioning
  self.x = x
  self.y = y
end

function Player:move(dx, dy)
  -- 
  self.x = self.x + dx
  self.y = self.y + dy
end

function Player:altMove(x, y, dt)
  x = x or 0
  y = y or 0
  dt = dt or 0
  -- really, we should just be throwing an error because something went terribly wrong
  self.x = self.x + (self.speed*x*dt)
  self.y = self.y + (self.speed*y*dt)
end