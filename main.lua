--[[ @TODO:
  1) Syncronize cursor objects.
  2) Create a settings modal.
  7) Make the overloaded print respect text formatting OR make the multiline textinput non-editable.
  8) Pimp out the globals viewer modal.
 10) Network stats.
 11) Push debug bar modal into lists.
 13) Crush global variables.
 14) Syncronize objects cross-network.
 15) Unify modals and components to use less globals.
 16) Mass-import/require libraries.
 18) Autocomplete.
 19) Condense number of network events that unofficially populate a new player.
 20) Re-associate the username to the player text.
 21) Force a failure on connect if server fails to respond.
 22) Make a window that visualizes settings / registered variable watchers.

https://developer.valvesoftware.com/wiki/TF2_Network_Graph

 bugs:
 1) Print overload function doesn't handle multiple argument outputs.
 2) Console print intercept doesn't properly handle misc types like userdata.
 3) Loading corrupt settings.txt results in total failure. (Overwritten, not joined.)
]]

--[[ Current Task:
  ???
]]
function love.load()
  math.randomseed(os.time())
  require("comps.globals")
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
  require("libs.lube")
  require("libs.tserial")
  require("libs.loveframes")
  
  game.graphs.fps = fpsgraph.createGraph()
  game.graphs.mem = fpsgraph.createGraph(0, 30)
  
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
  
  game.t = 0 -- (re)set t to 0
end

function love.update(dt)
  --[[
  game.t = game.t + dt
  if game.t > game.net.timestep then
    
    --collect inputs
    
    game.net.tick = game.net.tick + 1
    game.t = game.t - game.net.timestep
    
    
  ]]
  if game.isClient then
    if game.isProbeAccepted then
      game.t = game.t + dt
      if game.t > game.updaterate then
        local x, y = 0, 0
        if love.keyboard.isDown('up') then  y=y-(20*game.t) end
        if love.keyboard.isDown('down') then    y=y+(20*game.t) end
        if love.keyboard.isDown('left') then    x=x-(20*game.t) end
        if love.keyboard.isDown('right') then   x=x+(20*game.t) end
      
        --world[entity] = {world[entity].x+x, world[entity].y+y}
        game.world.players[game.net.myID]:move(x,y)
        sendMessage(client, 'move', {player=game.net.myID,x=x, y=y})
        sendMessage(client, 'update', {player=game.net.myID})
        game.t=game.t-game.updaterate -- set t for the next round
      end
    end
    client:update(dt)
  end
  if game.isServer then
    server:update(dt)
  end
  loveframes.update(dt)
  tween.update(dt)
  
  fpsgraph.updateFPS(game.graphs.fps, dt)
  fpsgraph.updateMem(game.graphs.mem, dt)
end

function love.draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(resources.img.bg, 0, 0, 0, resources.img.bgscalex, resources.img.bgscaley)
  
  for k, v in pairs(game.world.players) do
    v:draw()
  end
  loveframes.draw()
  
  love.graphics.setColor(0, 0, 255)
  fpsgraph.drawGraphs({game.graphs.fps, game.graphs.mem})
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
  if key == "`" then
    debug_bar.ToggleConsole()
  elseif key == "escape" then
    love.event.quit()
  elseif key == "q" then
    -- debug button \o/
    debug_bar.console_log:MoveIndicator(1)
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
end

function love.quit()
  if game.debug.dumpConsoleOnExit then
    love.filesystem.write('log.txt', debug_bar.console_log:GetText())
  end
  -- @TODO: Only dump settings when relevant, never on exit.
  love.filesystem.write("settings.txt", Tserial.pack(sets))
end