connect_panel = {}

function connect_panel.func()  
  connect_panel.frame = loveframes.Create("frame")
  connect_panel.frame.visible = false
  connect_panel.frame:SetIcon("resources/images/silk/connect.png")
	connect_panel.frame:SetName("Connect Panel")
	connect_panel.frame:SetSize(280, 150)
  -- decentralize from demo
	connect_panel.frame:CenterWithinArea(unpack({5, 40, 540, 555}))
  connect_panel.frame.OnClose = function(object)
    connect_panel.func()
  end
  
  connect_panel.username_label = loveframes.Create("text", connect_panel.frame)
	connect_panel.username_label:SetPos(5, 35)
	connect_panel.username_label:SetText("Username")
  
  connect_panel.username_input = loveframes.Create("textinput", connect_panel.frame)
	connect_panel.username_input:SetPos(75, 30)
	connect_panel.username_input:SetWidth(200)
  rand = tostring(math.random(99999))
  connect_panel.username_input:SetValue(rand)
  
  connect_panel.host_label = loveframes.Create("text", connect_panel.frame)
	connect_panel.host_label:SetPos(5, 65)
	connect_panel.host_label:SetText("Host")
	
	connect_panel.host_input = loveframes.Create("textinput", connect_panel.frame)
	connect_panel.host_input:SetPos(75, 60)
	connect_panel.host_input:SetWidth(200)
  connect_panel.host_input:SetValue(sets.net.address)
  
  connect_panel.port_label = loveframes.Create("text", connect_panel.frame)
	connect_panel.port_label:SetPos(5, 95)
	connect_panel.port_label:SetText("Port")
	
	connect_panel.port_input = loveframes.Create("textinput", connect_panel.frame)
	connect_panel.port_input:SetPos(75, 90)
	connect_panel.port_input:SetWidth(200)
  connect_panel.port_input:SetValue(sets.net.port)
  
  connect_panel.connect_button = loveframes.Create("button", connect_panel.frame)
	connect_panel.connect_button:SetPos(5, 120)
	connect_panel.connect_button:SetWidth(135)
	connect_panel.connect_button:SetText("Connect")
	connect_panel.connect_button.OnClick = function ()
    -- @TODO: Save as "last connection settings".
    launchClient(connect_panel.username_input:GetValue(), connect_panel.host_input:GetValue(), tonumber(connect_panel.port_input:GetValue()))
    connect_panel.ToggleVisible()
  end
  
  connect_panel.host_button = loveframes.Create("button", connect_panel.frame)
	connect_panel.host_button:SetPos(140, 120)
	connect_panel.host_button:SetWidth(135)
	connect_panel.host_button:SetText("Host")
	connect_panel.host_button.OnClick = function ()
    -- @TODO: See previous.
    launchServer(tonumber(connect_panel.port_input:GetValue()))
    launchClient(connect_panel.username_input:GetValue(), "localhost", tonumber(connect_panel.port_input:GetValue()))
    connect_panel.ToggleVisible()
  end
end

function connect_panel.ToggleVisible()
  connect_panel.frame.visible = not connect_panel.frame.visible
end
  