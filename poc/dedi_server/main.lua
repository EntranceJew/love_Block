function love.load()
  require("lube")
  require("network")
  require("server")
  launchServer(12345)
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
    sendMessage(server, '', 'msg', 'I hate you.')
  end
end