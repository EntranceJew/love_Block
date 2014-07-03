--[[
@TODO:
client to server:
  tick#
  acknowledgement#
  { "user command", args={...} }

engine commands
  bind
  alias
  exec

user commands:
  +north/south/east/west
  
  toggleconsole
  clear -- clears console
  
  save
  load
  
  screenshot
  
  
  cl_loveframes_debug 0/1/null
  cl_clear_console
  cl_connect_panel 0/1/null
  cl_connect
  cl_host
  
user keybinds:
  up/down/left/right  
  `       open console
  escape  exit application
  q       debug bind
  f5      savestate
  f7      loadstate
  f12     screenshot
]]

function configDo(thestring)
  -- get just the command
  i, _ = string.find(thestring, ' ')
  command=string.sub(thestring, 1, i-1)
  arguments=string.sub(thestring, i+1)
  if a
  return arguments
end

function qfind( s )
  local ok, a, b = string.match( " "..s, "[^\\](\\*)%1()[\"']()" )
  if ok then
    return a-1, b-1
  end
  return nil
end