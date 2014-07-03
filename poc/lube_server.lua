function love.load()
  require("lube")
  
  server = lube.udpServer()

  server:setPing(true, 0.1, "ping hala")

  server:listen(12345)
  
  server.callbacks.recv = serverRecv
  server.callbacks.connect = serverConnect
  server.callbacks.disconnect = serverDisconnect
end
function serverRecv(data, clientid)
  print("[LUBE|server] client " .. clientid .." said: "..data)
end
function serverConnect(clientid)
  print("[LUBE|server] client " .. clientid .. " connected!")
end
function serverDisconnect(clientid)
  print("[LUBE|server] client " .. clientid .. " disconnected!")
end

function love.update(dt)
  server:update(dt)
end

function love.draw()
  -- i'm gay as heck
end

function love.keypressed(k)
  if k=='escape' then
    server:send("I think you are all so gay.")
  end
end