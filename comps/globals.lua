game = {
  state = 'main', -- main, host, client
  isServer = false,
  isClient = false,
  isProbeAccepted = false,
  net = {
    myID = 1,
    clientIndex = 1,
    rate_tick = 0.020, --sec, 15ms tick rate = 66/s
    -- supposed to be 0.015 but that causes the tickrate to go faster than the game
    rate_update = 0.05,  --updates/second, 20
    tick = 0,
  },
  timers = {
    tick = 0,
    update = 0,
  },
  graphs = {
  },
  history = { -- this is where ???
    
  },
  console = {
    -- -1 = no limit
    scrollback_limit = 5,
    -- -1 = no limit
    history_limit = 50
  },
  debug = {
    dumpConsoleOnExit = true
  },
  t = 0,
  updaterate = 0.1,
  spawnpoint = {x=320, y=240},
  world = {
    players = {}
  }
}

resources = {
  img = {
    bg = love.graphics.newImage("resources/images/bg.png")
  }
}
resources.img.bgscalex = love.graphics.getWidth()/resources.img.bg:getWidth()
resources.img.bgscaley = love.graphics.getHeight()/resources.img.bg:getHeight()