utils = {}

utils.tablelength = function(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

utils.countlines = function(text_string)
  return select(2, text_string:gsub('\n', '\n'))+1
end

utils.clog = function(data)
  love.filesystem.write('log.txt', data)
end

utils.screenshot = function()
  commence = true
  if not love.filesystem.isDirectory('screenshots') then
    commence = love.filesystem.createDirectory('screenshots')
  end
  if not commence then
    print("Unable to create screenshot directory. Could not save screenshot.")
    return false
  else
    screenshot = love.graphics.newScreenshot(true)
    timestart = os.time()
    attempts = 0
    base_filename = 'screenshot-'..timestart..'.png'
    repeat
      base_filename = 'screenshot-'
      if timestart ~= os.time() then
        timestart = os.time()
        attempts = 0
      end
      base_filename = base_filename..timestart
      if attempts > 0 then
        base_filename = base_filename..'-'..attempts
      end
      base_filename = base_filename .. '.png'
      exists = love.filesystem.isFile('screenshots/'..base_filename)
    until not exists
    screenshot:encode('screenshots/'..base_filename, 'png')
    return 'screenshots/'..base_filename
  end
end

utils.shallowcopy = function(orig)
  local orig_type = type(orig)
  local copy
  if orig_type == 'table' then
      copy = {}
      for orig_key, orig_value in pairs(orig) do
          copy[orig_key] = orig_value
      end
  else -- number, string, boolean, etc
      copy = orig
  end
  return copy
end

utils.register_entity = function(identifier, world, history)
  if type(world[identifier]) ~= "table" then
    world[identifier] = {}
  end
  if type(history[identifier]) ~= "table" then
    history[identifier] = {}
  end
end

utils.savestate_raw = function()
  local state = utils.shallowcopy(game.world)
  --[[for ent_type, entities in pairs(state) do
    for ent_index, entity in pairs(entities) do
      entity.class = nil
    end
  end]]
  
  return state
end

utils.savestate = function(filename)
  filename = filename or "savestate.txt"
  for k,v in pairs(game.world.players) do
    game.world.players[k].class = nil
  end
  savestate = game
  love.filesystem.write(filename, serialize(savestate))
end

utils.loadstate = function(filename)
  filename = filename or "savestate.txt"
  loadstate = loadstring(love.filesystem.read(filename))()
  for k,v in pairs(loadstate.world.players) do
    loadstate.world.players[k] = Player(v.name, v.x, v.y)
  end
  game = loadstate
end