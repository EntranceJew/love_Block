--[[ @TODO:
  1) Syncronize cursor objects.
  2) Create a settings modal.
  3) Save/Load settings to a file.
  4) Prompt to bomb outdated / corrupt settings.
  5) Replace networking model with lube.
  6) Hook and parse the console_parse method.
  7) Make the overloaded print respect text formatting OR make the multiline textinput non-editable.
  8) Pimp out the globals viewer modal.
  9) Refurb the connection modal.
 10) Network stats.
 11) Push debug bar modal into lists.
]]
nop = function()
  return ""
end

function console_parse(text)
  text = text or ""
  -- @TODO: #6
  print("> "..text)
end

cprint = print
print = function(text, extra)
  text = text or ""
  if text ~= "" then
    cprint(text)
    local console = debug_bar.console_log:GetText()
    console = console:gsub(" \n ", "\n")
    -- @TODO: #7
    -- cprint(Tserial.pack(console, nop, true))
    -- table.insert(console, {color = debug_bar.console_log:GetDefaultColor()})
    -- table.insert(console, message)
    debug_bar.console_log:SetText(console.."\n"..text)
  end
end

socket = require "socket"

-- the address and port of the server
address, port = "localhost", 12345

entity = {} -- entity is what we'll be controlling
updaterate = 0.1 -- how long to wait, in seconds, before requesting an update

gamestate = 'main' -- main, host, client

world = {} -- the empty world-state
t = 0

udp = socket.udp()
udp:settimeout(0)

function connect(connection_type, c_port, username, c_address)
  c_port = c_port or port
  c_address = c_address or address
  username = username or port
  gamestate = connection_type
  entity = username
  world[entity] = {x=320, y=240}
  -- TODO: 
  if connection_type == 'host' then
    udp:setsockname('*', c_port)
  elseif connection_type == 'client' then
    udp:setpeername(c_address, c_port)
    local dg = string.format("%s %s %d %d", entity, 'at', 320, 240)
    udp:send(dg) -- the magic line in question.
  end
  
end

-- love.load, hopefully you are familiar with it from the callbacks tutorial
function love.load()
  math.randomseed(os.time())
  tween = require("libraries.third-party.tween")
  lube = require("libraries.third-party.lube")
  require("libraries.third-party.tserial")
  require("libraries.loveframes")
  require("modals.debug_bar")
  require("modals.connect_panel")
  require("modals.not_implemented")
  require("modals.globals_viewer")
  --require("modals.video_settings")
  debug_bar.func()
  connect_panel.func()
  not_implemented.func()
  globals_viewer.func()
  --video_settings.func()
  love.filesystem.write('awyeah.txt','suckmydick')
  
  bgimage = love.graphics.newImage("resources/images/bg.png")
  
  -- t is just a variable we use to help us with the update rate in love.update.
  t = 0 -- (re)set t to 0
end

-- love.update, hopefully you are familiar with it from the callbacks tutorial
function love.update(dt)
  if gamestate == 'main' then
    -- if love.keyboard.isDown('c') then  connect('client') end
    -- if love.keyboard.isDown('h') then  connect('host') end
  else
    t = t + dt -- increase t by the dt
    if t > updaterate then
      local x, y = 0, 0
      if love.keyboard.isDown('up') then  y=y-(20*t) end
      if love.keyboard.isDown('down') then    y=y+(20*t) end
      if love.keyboard.isDown('left') then    x=x-(20*t) end
      if love.keyboard.isDown('right') then   x=x+(20*t) end

      if gamestate == 'host' then
        world[entity] = {x=world[entity].x+x, y=world[entity].y+y}
      elseif gamestate == 'client' then
        local dg = string.format("%s %s %f %f", entity, 'move', x, y)
        udp:send(dg)
        local dg = string.format("%s %s $", entity, 'update')
        udp:send(dg)
      end
      
      t=t-updaterate -- set t for the next round
    end
    repeat
      if gamestate == 'client' then
        data, msg_or_ip = udp:receive()
      elseif gamestate == 'host' then
        data, msg_or_ip, port_or_nil = udp:receivefrom()
      end
      if data then
        ent, cmd, parms = data:match("^(%S*) (%S*) (.*)")
        if cmd == 'move' then
          local x, y = parms:match("^(%-?[%d.e]*) (%-?[%d.e]*)$")
          assert(x and y) -- validation is better, but asserts will serve.
          -- don't forget, even if you matched a "number", the result is still a string!
          -- thankfully conversion is easy in lua.
          x, y = tonumber(x), tonumber(y)
          -- and finally we stash it away
          local enty = world[ent] or {x=0, y=0}
          world[ent] = {x=enty.x+x, y=enty.y+y}
        elseif cmd == 'at' then
          -- more patterns, this time with sets, and more length selectors!
          local x, y = parms:match("^(%-?[%d.e]*) (%-?[%d.e]*)$")
          assert(x and y) -- validation is better, but asserts will serve.
          x, y = tonumber(x), tonumber(y)
          world[ent] = {x=x, y=y}
        elseif cmd == 'update' then
          for k, v in pairs(world) do
            udp:sendto(string.format("%s %s %d %d", k, 'at', v.x, v.y), msg_or_ip,  port_or_nil)
          end
        elseif cmd == 'quit' then
          love.quit()
        else
            print("unrecognised command:", cmd)
        end
      -- elseif msg_or_ip ~= 'timeout' then
      --  error("Network error: "..tostring(msg))
      end
    until not data
  end
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
  
  for k, v in pairs(world) do
    love.graphics.print(k, v.x, v.y)
  end
  loveframes.draw()
end

function love.mousepressed(x, y, button)
  loveframes.mousepressed(x, y, button)
end
 
function love.mousereleased(x, y, button)
  loveframes.mousereleased(x, y, button)
end
 
function love.keypressed(key, unicode)
  loveframes.keypressed(key, unicode)
end
 
function love.keyreleased(key)
  loveframes.keyreleased(key)
end

function love.textinput(text)
  loveframes.textinput(text)
end