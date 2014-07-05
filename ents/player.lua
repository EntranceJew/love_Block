Player = class('Player')
local identifier = 'players'
function Player:initialize(name, x, y)
  self.world = game.world
  self.name = name
  self.x = x
  self.y = y
  
  self.net_history = {}
  -- keyed by tick number
  
  self.speed = 200 -- MYSTERY UNITS~
  self.world_id = #self.world[identifier]+1
  self.world[identifier][self.world_id] = self
  -- network announce object position
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
  -- I really don't really have anything to think about right now.
  -- I like dogs.
end

function Player:draw()
  love.graphics.print(self.name, self.x, self.y)
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