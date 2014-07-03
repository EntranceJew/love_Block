globals_viewer = {}
globals_viewer.gostate = true
function globals_viewer.func()
	globals_viewer.frame = loveframes.Create("frame")
  globals_viewer.frame.visible = false
  globals_viewer.frame:SetIcon("resources/images/silk/controller.png")
	globals_viewer.frame:SetName("Globals Viewer")
	globals_viewer.frame:SetSize(500, 324)
	globals_viewer.frame:CenterWithinArea(unpack({5, 40, 540, 555}))
  globals_viewer.frame.OnClose = function(object)
    globals_viewer.func()
  end
  
  globals_viewer.text_filter = loveframes.Create("textinput", globals_viewer.frame)
  globals_viewer.text_filter:SetPos(5, 30)
  globals_viewer.text_filter:SetWidth(490)
	
	globals_viewer.glist = loveframes.Create("columnlist", globals_viewer.frame)
	globals_viewer.glist:SetPos(5, 60)
	globals_viewer.glist:SetSize(490, 235)
	globals_viewer.glist:AddColumn("Key")
	globals_viewer.glist:AddColumn("Value")
  --globals_viewer.glist:SetAutoScroll(false)
  
  globals_viewer.button_panel = loveframes.Create("panel", globals_viewer.frame)
  globals_viewer.button_panel:SetPos(5, 300)
  globals_viewer.button_panel:SetSize(490, 18)
  
  globals_viewer.upscope_button = loveframes.Create("imagebutton", globals_viewer.button_panel)
	globals_viewer.upscope_button:SetImage("resources/images/silk/arrow_turn_left.png")
	globals_viewer.upscope_button:SetPos(1, 1)
  globals_viewer.upscope_button:SetText("")
	globals_viewer.upscope_button:SizeToImage()
  globals_viewer.upscope_button.OnClick = function(object, x, y)
		not_implemented.ToggleVisible()
	end
  
  globals_viewer.enterscope_button = loveframes.Create("imagebutton", globals_viewer.button_panel)
	globals_viewer.enterscope_button:SetImage("resources/images/silk/arrow_right.png")
	globals_viewer.enterscope_button:SetPos(18, 1)
  globals_viewer.enterscope_button:SetText("")
	globals_viewer.enterscope_button:SizeToImage()
  globals_viewer.enterscope_button.OnClick = function(object, x, y)
		not_implemented.ToggleVisible()
	end
  
  globals_viewer.playpause_button = loveframes.Create("imagebutton", globals_viewer.button_panel)
	globals_viewer.playpause_button:SetImage("resources/images/silk/control_pause.png")
	globals_viewer.playpause_button:SetPos(36, 1)
  globals_viewer.playpause_button:SetText("")
	globals_viewer.playpause_button:SizeToImage()
  globals_viewer.playpause_button.OnClick = function(object, x, y)
    if globals_viewer.gostate then
      object:SetImage("resources/images/silk/control_play.png")
    else
      object:SetImage("resources/images/silk/control_pause.png")
    end
    globals_viewer.gostate = not globals_viewer.gostate
		not_implemented.ToggleVisible()
	end
  
  globals_viewer.edit_button = loveframes.Create("imagebutton", globals_viewer.button_panel)
	globals_viewer.edit_button:SetImage("resources/images/silk/pencil.png")
	globals_viewer.edit_button:SetPos(54, 1)
  globals_viewer.edit_button:SetText("")
	globals_viewer.edit_button:SizeToImage()
  globals_viewer.edit_button.OnClick = function(object, x, y)
		not_implemented.ToggleVisible()
	end
  
  globals_viewer.refresh_button = loveframes.Create("imagebutton", globals_viewer.button_panel)
	globals_viewer.refresh_button:SetImage("resources/images/silk/arrow_refresh.png")
	globals_viewer.refresh_button:SetPos(72, 1)
  globals_viewer.refresh_button:SetText("")
	globals_viewer.refresh_button:SizeToImage()
  globals_viewer.refresh_button.OnClick = function(object, x, y)
    globals_viewer.glist:Clear()
		for k, v in pairs(_G) do
      local value_str = ""
      globals_viewer.glist:AddRow(k, tostring(v))
    end
	end
  
  globals_viewer.frame.Update = function(object, dt)
    globals_viewer.glist:SelectRow(1)
    --[[globals_viewer.glist:Clear()
    for k, v in pairs(_G) do
      local value_str = ""
      globals_viewer.glist:AddRow(k, tostring(v))
    end]]
  end
  
  for k, v in pairs(_G) do
    local value_str = ""
    globals_viewer.glist:AddRow(k, tostring(v))
  end
end

function globals_viewer.ToggleVisible()
  globals_viewer.frame.visible = not globals_viewer.frame.visible
end