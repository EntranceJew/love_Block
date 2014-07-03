Player = class('Player')

function Player:initialize(name, x, y)
  self.name = name
  self.x = x
  self.y = y
  -- network announce object position
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