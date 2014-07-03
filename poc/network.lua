function launchClient(uname, host, port)
  print("[LUBE|client] connecting...")
  client = lube.udpClient()
  client:setPing(true, 0.1, "pingu")
  client.callbacks.recv = clientRecv
  local suc, err = client:connect(host, port)
  if suc then
    gamestate = 'client'
    isClient = true
    entity = uname
    world[entity] = {x=320, y=240}
    client:send(string.format("%s %s %d %d", entity, 'at', 320, 240))
    --sendMessage(client, entity, 'update')
    print("[LUBE|client] connection made")
  else
    print("[LUBE|client] connection failed")
    print("[LUBE|client] failure code: "..tostring(err))
  end
end


function clientRecv(data)
  ent, cmd, parms = data:match("^(%S*) (%S*) (.*)")
  if cmd == 'at' then
    local x, y = parms:match("^(%-?[%d.e]*) (%-?[%d.e]*)$")
    assert(x and y)
    x, y = tonumber(x), tonumber(y)
    world[ent] = {x=x, y=y}
  else
    print("unrecognised command:", cmd)
  end
end

function launchServer(port)
  server = lube.udpServer()
  server:setPing(true, 0.1, "pingu")
  server.callbacks.recv = serverRecv
  server.callbacks.connect = serverConnect
  server.callbacks.disconnect = serverDisconnect
  gamestate = 'server'
  isServer = true
  print("[LUBE|server] starting...")
  server:listen(port)
  print("[LUBE|server] listening on port " .. port)
end

function serverRecv(data, clientid)
  -- print("[LUBE|server] client " .. clientid .." said: "..data)
  local entity, cmd, parms = data:match("^(%S*) (%S*) (.*)")
  if cmd == 'move' then
    local x, y = parms:match("^(%-?[%d.e]*) (%-?[%d.e]*)$")
    assert(x and y) -- validation is better, but asserts will serve.
    -- don't forget, even if you matched a "number", the result is still a string!
    -- thankfully conversion is easy in lua.
    x, y = tonumber(x), tonumber(y)
    -- and finally we stash it away
    local ent = world[entity] or {x=0, y=0}
    world[entity] = {x=ent.x+x, y=ent.y+y}
  elseif cmd == 'at' then
    local x, y = parms:match("^(%-?[%d.e]*) (%-?[%d.e]*)$")
    assert(x and y) -- validation is better, but asserts will serve.
    x, y = tonumber(x), tonumber(y)
    world[entity] = {x=x, y=y}
  elseif cmd == 'update' then
    for k, v in pairs(world) do
      server:send(string.format("%s %s %d %d", k, 'at', v.x, v.y), clientid)
    end
  elseif cmd == 'quit' then 
    love.quit()
  else
    print("unrecognised command:", cmd)
  end
end

function serverConnect(clientid)
  print("[LUBE|server] client " .. clientid .. " connected!")
end

function serverDisconnect(clientid)
  print("[LUBE|server] client " .. clientid .. " disconnected!")
end