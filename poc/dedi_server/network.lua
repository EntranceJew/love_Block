--[[ network commands
at: declares position
move(x, y): changes relative position
update:
quit: stops the server
]]

function sendMessage(handle, ent, cmd, parms, clientid)
  if type(parms) ~= "table" then
    parms = {parms}
  end
  handle:send(string.format("%s %s %d %d", ent, cmd, unpack(parms), clientid))
end

function parseMessage(data, clientid)
  ent, cmd, parms = data:match("^(%S*) (%S*) (.*)")
  if cmd == 'move' then
    local x, y = parms:match("^(%-?[%d.e]*) (%-?[%d.e]*)$")
    assert(x and y)
    x, y = tonumber(x), tonumber(y)
    local enty = world[ent] or {x=0, y=0}
    world[ent] = {x=enty.x+x, y=enty.y+y}
  elseif cmd == 'at' then
    local x, y = parms:match("^(%-?[%d.e]*) (%-?[%d.e]*)$")
    assert(x and y)
    x, y = tonumber(x), tonumber(y)
    world[ent] = {x=x, y=y}
  elseif cmd == 'update' then
    for k, v in pairs(world) do
      sendMessage(server, k, 'at', {v.x, v.y}, clientid)
    end
  elseif cmd == 'quit' then
    love.quit()
  elseif cmd == 'msg' then
    print(parms)
  else
    print("[LUBE|parse] unrecognised command: " .. cmd)
  end
end