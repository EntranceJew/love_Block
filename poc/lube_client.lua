function love.load()
  require("lube")
  
  client = lube.udpClient()

  client:setPing(true, 0.1, "ping hala")

  success, err = client:connect("localhost", 12345)
  print("[LUBE|client] connect status: "..tostring(success))
  print("[LUBE|client] connect error: "..tostring(err))

  client:send("im gay as heck")
  
  client.callbacks.recv = clientRecv
end

function clientRecv(data)
  print("[LUBE|client] server said: " .. data)
end

function love.update(dt)
  client:update(dt)
end

function love.draw()
  -- i'm gay as heck
end

function love.keypressed(k)
  if k=='escape' then
    client:send("I am so gay.")
  end
end