--[[ Current Task:
  1) moving a TLbind instance into each playable entity
  2) automatic inclusion of comps, libs, modals, ents
  3) savestate code to make a server snapshot
  7) reroute entities to apply processing to a snapshotted dohickey
]]
function love.load()
  require("comps.globals")
  math.randomseed(game.engine.seed_start)
  require("comps.settings")
  require("comps.console")
  require("comps.network")
  require("comps.utils")
  
  -- require libs
  tween = require("libs.tween")
  class = require("libs.middleclass")
  inspect = require("libs.inspect")
  serialize = require("libs.ser")
  fpsgraph = require "libs.FPSGraph"
  TLbind = require("libs.TLbind") --love.filesystem.load("libs/TLbind.lua")()
  require("libs.lube")
  require("libs.tserial")
  require("libs.loveframes")
  require("libs.monocle")
  Monocle.new({
      isActive=true,
      customPrinter=false,
      printColor = {51, 51, 51},
      debugToggle = 'f1',
      filesToWatch =
        {
          'main.lua'
        }
  })
  --Monocle.watch("FPS", function() return math.floor(1/love.timer.getDelta()) end)
  Monocle.watch("in", function() return inspect(game.world.players[1].binds.control) end)
  --Monocle.watch("tick:rate", function() return game.timers.tick..":"..game.net.rate_tick end)
  
  game.graphs.fps = fpsgraph.createGraph()
  game.graphs.mem = fpsgraph.createGraph(0, 30)
  game.graphs.tick = fpsgraph.createGraph(0, 60)
  
  loveframes.util.SetActiveSkin("Blu")
  
  -- @TODO: Put settings validation and parsing in place.
  if love.filesystem.exists("settings.txt") then
    sets = Tserial.unpack(love.filesystem.read("settings.txt"), true)
  else
    love.filesystem.write("settings.txt", Tserial.pack(sets))
  end
  
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
  
  -- require entities
  require("ents.player")
  
  p1 = Player('dad', 320, 240)
  p1:setControls(sets.controls.player1)
  p2 = Player('mom', 240, 320)
  p1.spin_speed = p1.spin_speed*2
  -- @TEST: circumvent netcode for now
  
  game.t = 0 -- (re)set t to 0
end

function love.update(dt)
  --game.t = game.t + dt -- @WARNING: this variable will approach infinity now \o/
  game.timers.tick = game.timers.tick + dt
  game.timers.update = game.timers.update + dt
  if game.timers.tick >= game.net.rate_tick then
    -- this here logic should be inside the player :colbert:
    for k, v in pairs(game.world.players) do
      v:update(game.timers.tick)
    end
    
    --[[local c, u = 0, 0
    if love.keyboard.isDown('w') then      u=-1 end
    if love.keyboard.isDown('s') then    u=1  end
    if love.keyboard.isDown('a') then    c=-1 end
    if love.keyboard.isDown('d') then   c=1  end
    
    game.world.players[2]:network_proxy('altMove', {c,u,game.timers.tick})]]
    
    --world[entity] = {world[entity].x+x, world[entity].y+y}
    --game.world.players[game.net.myID]:network_action(game.net.tick, love.timer.getTime(), 'altMove', {x,y,game.timers.tick}) 
    
    --game.world.players[game.net.myID]:altMove(x,y,game.timers.tick)
    --[[ need to bind through client(s) and not through player]]
    
    -- the above line looks dumb
    -- that is because it is, it circumvents client-server messaging
    
    -- below: stubbed netcode
    --sendMessage(client, 'move', {player=game.net.myID,x=x, y=y})
    --sendMessage(client, 'update', {player=game.net.myID})
    game.timers.tick = game.timers.tick - game.net.rate_tick -- set t for the next round
    game.net.tick = game.net.tick + 1
  end
  
  if game.timers.update >= game.net.rate_update then
    -- Timer exceeds update rate, open gullet for some tasty network updates.
    if game.isClient then
      client:update(game.timers.update)
    end
    if game.isServer then
      server:update(game.timers.update)
    end
    game.timers.update = game.timers.update - game.net.rate_update
  end
  loveframes.update(dt)
  tween.update(dt)
  Monocle.update()
  TLbind:update()
  
  fpsgraph.updateFPS(game.graphs.fps, dt)
  fpsgraph.updateMem(game.graphs.mem, dt)
  fpsgraph.updateGraph(game.graphs.tick, game.timers.tick, "Tick: " .. game.timers.tick, dt)
end

function love.draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(resources.img.bg, 0, 0, 0, resources.img.bgscalex, resources.img.bgscaley)
  
  for k, v in pairs(game.world.players) do
    v:draw()
  end
  loveframes.draw()
  Monocle.draw()
  love.graphics.setColor(0, 0, 255)
  fpsgraph.drawGraphs({game.graphs.fps, game.graphs.mem, game.graphs.tick})
end

function love.mousepressed(x, y, button)
  loveframes.mousepressed(x, y, button)
end
 
function love.mousereleased(x, y, button)
  loveframes.mousereleased(x, y, button)
end
 
function love.keypressed(key, unicode)
  loveframes.keypressed(key, unicode)
  Monocle.keypressed(key)
end
 
function love.keyreleased(key)
  if key == "`" then
    debug_bar.ToggleConsole()
  elseif key == "escape" then
    love.event.quit()
  elseif key == "q" then
    -- debug button \o/
    --debug_bar.console_log:MoveIndicator(1)
    game.world.players[1]:at(320, 240)
    game.world.players[1]:replay_from_tick(0)
  end
  
  if key == "f5" then
    print("Saving state as savestate.txt")
    utils.savestate("savestate.txt")
  elseif key == "f7" then
    print("Loading state from savestate.txt")
    utils.loadstate("savestate.txt")
  elseif key == "f12" then
    outname = utils.screenshot()
    print("Saved screenshot to "..tostring(outname))
  end
  if debug_bar.console_input:GetFocus() then
    if key == "up" then
      debug_bar.console_input:ResetSelection()
      local scrollback_size = utils.tablelength(debug_bar.scrollback)
      debug_bar.scrollback_index = debug_bar.scrollback_index - 1
      if debug_bar.scrollback_index < 1 then
        debug_bar.scrollback_index = 1
      end
      if scrollback_size ~= 0 then
        debug_bar.console_input:SetText(debug_bar.scrollback[debug_bar.scrollback_index])
      end
    elseif key == "down" then
      debug_bar.console_input:ResetSelection()
      local scrollback_size = utils.tablelength(debug_bar.scrollback)
      
      debug_bar.scrollback_index = debug_bar.scrollback_index + 1
      if debug_bar.scrollback_index < scrollback_size+1 then
        debug_bar.console_input:SetText(debug_bar.scrollback[debug_bar.scrollback_index])
      elseif debug_bar.scrollback_index >= scrollback_size+1 then
        debug_bar.console_input:Clear()
        debug_bar.scrollback_index = scrollback_size+1
      end
    end
  end
  loveframes.keyreleased(key)
end

function love.textinput(text)
  loveframes.textinput(text)
  Monocle.textinput(text)
end

function love.quit()
  if game.debug.dumpConsoleOnExit then
    love.filesystem.write('log.txt', debug_bar.console_log:GetText())
  end
  -- @TODO: Only dump settings when relevant, never on exit.
  love.filesystem.write("settings.txt", Tserial.pack(sets))
end