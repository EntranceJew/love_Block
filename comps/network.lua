function launchClient(uname, host, port)
  print("[LUBE|client] connecting...")
  client = lube.udpClient()
  --client:setPing(true, 0.1, "pingu")
  client.callbacks.recv = clientRecv
  local suc, err = client:connect(host, tonumber(port))
  if suc then
    game.isClient = true
    --[[ Upon connection, probe the server to get a unique ID. ]]
    print("[LUBE|client] probing server")
    sendMessage(client, 'probe')
  else
    print("[LUBE|client] connection failed")
    print("[LUBE|client] failure code: "..tostring(err))
  end
end

function sendMessage(interface, command, parameters, clientid)
  local built = {cmd=command,params=parameters}
  if clientid ~= nil then
    interface:send(Tserial.pack(built), clientid)
  else
    interface:send(Tserial.pack(built))
  end
end

function launchServer(port)
  server = lube.udpServer()
  server:setPing(true, 0.1, "pingu")
  server.callbacks.recv = serverRecv
  server.callbacks.connect = serverConnect
  server.callbacks.disconnect = serverDisconnect
  print("[LUBE|server] starting...")
  server:listen(tonumber(port))
  game.isServer = true
  print("[LUBE|server] listening on port " .. port)
end

function clientRecv(data)
  local ndata = Tserial.unpack(data, false)
  if ndata.cmd == 'at' then
    local x, y = ndata.params.x, ndata.params.y
    assert(x and y)
    x, y = tonumber(x), tonumber(y)
    -- @TODO: Validate received player id.
    if game.world.players[ndata.params.player] ~= nil then
      --print("<WARNING:at>[LUBE|client] suppressed overwriting player index "..ndata.params.player)
      game.world.players[ndata.params.player]:at(x,y)
    else
      print("<WARNING:at>[LUBE|client] created new players outside of probe"..ndata.params.player)
      game.world.players[ndata.params.player] = Player(ndata.params.player, x, y)
    end
  elseif ndata.cmd == 'probe_accept' then
    print("[LUBE|client] probe accepted id#"..ndata.params.player)
    local x, y = ndata.params.x, ndata.params.y
    assert(x and y)
    x, y = tonumber(x), tonumber(y)
    for k, v in pairs(ndata.params.players) do
      if game.world.players[k] ~= nil then
        print("<WARNING|extra>[LUBE|client] suppressed overwriting player index "..ndata.params.player)
      else
        print("<debug>[LUBE|client] built fellow client#"..k.." from probe")
        game.world.players[k] = Player(k, v.x, v.y)
      end
    end
    if game.world.players[ndata.params.player] ~= nil then
      print("<WARNING>[LUBE|client] suppressed overwriting player index "..ndata.params.player)
    else
      game.world.players[ndata.params.player] = Player(ndata.params.player, x, y)
    end
    game.net.myID = ndata.params.player
    game.isProbeAccepted = true
    print("[LUBE|client] connection made")
  elseif ndata.cmd == 'probe_deny' then
    print("[LUBE|client] probe to server denied, unknown error")
    -- @TODO: Unhook everything to a fresh pre-connect state.
  else
    print("[LUBE|server] Unrecognised command: ", ndata.cmd)
  end
end

function serverRecv(data, clientid)
  local ndata = Tserial.unpack(data, false)
  if ndata.cmd == 'probe' then
    print("[LUBE|server] client ("..clientid..") probing")
    --print("<debug>"..inspect(game.world.players))
    --print("<debug>"..inspect(game.world.players[game.net.clientIndex]))
    print("<debug>"..game.net.clientIndex)
    if game.world.players[game.net.clientIndex] ~= nil then
      sendMessage(server, 'probe_deny', {}, clientid)
      print("[LUBE|server] denied probe from client ("..clientid..")")
    else
      local x, y = game.spawnpoint.x, game.spawnpoint.y
      game.world.players[game.net.clientIndex] = Player(game.net.clientIndex, x, y)
      local build = {player=game.net.clientIndex,x=x,y=y,players={}}
      for k, v in pairs(game.world.players) do
        if k ~= game.net.clientIndex then
          build.players[k] = {x=v.x,y=v.y}
        end
      end
      sendMessage(server, 'probe_accept', build, clientid)
      print("[LUBE|server] accepted probe from client ("..clientid..") id#"..game.net.clientIndex)
      game.net.clientIndex = game.net.clientIndex + 1
    end
  elseif ndata.cmd == 'move' then
    local x, y = ndata.params.x, ndata.params.y
    assert(x and y)
    x, y = tonumber(x), tonumber(y)
    game.world.players[ndata.params.player]:move(x,y)
    -- @TODO: announce/relay
  elseif ndata.cmd == 'at' then
    -- @TODO: Do not accept "at" announcements from client.
    local x, y = ndata.params.x, ndata.params.y
    assert(x and y)
    x, y = tonumber(x), tonumber(y)
    game.world.players[ndata.player]:at(x,y)
  elseif ndata.cmd == 'update' then
    -- @TODO: Do not accept "update" requests from clients.
    for k, v in pairs(game.world.players) do
      if k ~= ndata.params.player then
        sendMessage(server, 'at', {player=k,x=v.x,y=v.y}, clientid)
      end
    end
  elseif ndata.cmd == 'quit' then 
    -- @TODO: DEFINITELY DO NOT LISTEN TO THIS.
    love.quit()
  else
    print("[LUBE|server] Unrecognised command: ", ndata.cmd)
  end
end

function serverConnect(clientid)
  print("[LUBE|server] client " .. clientid .. " connected!")
end

function serverDisconnect(clientid)
  print("[LUBE|server] client " .. clientid .. " disconnected!")
end