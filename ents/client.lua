Client = class('Client')
local identifier = 'clients'
function Client:initialize(clientid)
  self.world = game.world
  self.clientid = clientid or "localhost"
  
  self.player = 
  
  self.speed = 20 -- MYSTERY UNITS~
  self.world_id = #self.world[identifier]+1
  self.world[identifier][self.world_id] = self
  -- network announce object position
end

function Client:update(dt)
  -- I really don't really have anything to think about right now.
  -- I like dogs.
end

function Client:draw()
  --love.graphics.print(self.name, self.x, self.y)
end