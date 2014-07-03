game = {
  state = 'main', -- main, host, client
  isServer = false,
  isClient = false,
  isProbeAccepted = false,
  net = {
    myID = 0,
    clientIndex = 1
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