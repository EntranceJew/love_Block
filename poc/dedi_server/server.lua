function launchServer(port)
  server = lube.udpServer()
  server:setPing(true, 0.1, "pingu")
  server.callbacks.recv = serverRecv
  server.callbacks.connect = serverConnect
  server.callbacks.disconnect = serverDisconnect
  gamestate = 'server'
  print("[LUBE|server] starting...")
  server:listen(12345)
  print("[LUBE|server] listening on port " .. port)
end

function serverRecv(data, clientid)
  --print("[LUBE|server] client " .. clientid .." said: "..data)
  parseServerMessage(data, clientid)
end
function serverConnect(clientid)
  print("[LUBE|server] client " .. clientid .. " connected!")
end
function serverDisconnect(clientid)
  print("[LUBE|server] client " .. clientid .. " disconnected!")
end