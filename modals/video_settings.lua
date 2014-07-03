video_settings = {}

function video_settings.func()  
  video_settings.frame = loveframes.Create("frame")
  video_settings.frame.visible = false
  video_settings.frame:SetIcon("resources/images/silk/computer_edit.png")
	video_settings.frame:SetName("Video Settings")
	video_settings.frame:SetSize(190, 295)
	video_settings.frame:CenterWithinArea(unpack({5, 40, 540, 555}))
  video_settings.frame.OnClose = function(object)
    video_settings.func()
  end
  
  video_settings.list = loveframes.Create("list", video_settings.frame)
	video_settings.list:SetPos(5, 30)
	video_settings.list:SetSize(180, 260)
  
  -- Resolution
  video_settings.panel_resolution = loveframes.Create("panel")
  video_settings.panel_resolution:SetSize(180, 25)
  video_settings.label_resolution = loveframes.Create("text", video_settings.panel_resolution)
  video_settings.label_resolution:SetText("Resolution")
  video_settings.label_resolution:SetSize(90, 25)
  video_settings.label_resolution:SetX(5)
  video_settings.label_resolution:CenterY()
  
  video_settings.checkbox_resolution = loveframes.Create("checkbox", video_settings.panel_resolution)
  video_settings.checkbox_resolution:SetText("")
  video_settings.checkbox_resolution:SetSize(90, 25)
  video_settings.checkbox_resolution:SetPos(90, 0)
  
  video_settings.list:AddItem(video_settings.panel_resolution)
  
  -- Borderless
  video_settings.panel_borderless = loveframes.Create("panel")
  video_settings.panel_borderless:SetSize(180, 25)
  video_settings.label_borderless = loveframes.Create("text", video_settings.panel_borderless)
  video_settings.label_borderless:SetText("Borderless")
  video_settings.label_borderless:SetSize(90, 25)
  video_settings.label_borderless:SetX(5)
  video_settings.label_borderless:CenterY()
  video_settings.checkbox_borderless = loveframes.Create("checkbox", video_settings.panel_borderless)
  video_settings.checkbox_borderless:SetText("")
  video_settings.checkbox_borderless:SetSize(90, 25)
  video_settings.checkbox_borderless:SetPos(90, 0)
  video_settings.list:AddItem(video_settings.panel_borderless)
  
  -- Fullscreen X
  video_settings.panel_fullscreen = loveframes.Create("panel")
  video_settings.panel_fullscreen:SetSize(180, 25)
  video_settings.label_fullscreen = loveframes.Create("text", video_settings.panel_fullscreen)
  video_settings.label_fullscreen:SetText("Fullscreen")
  video_settings.label_fullscreen:SetSize(90, 25)
  video_settings.label_fullscreen:SetX(5)
  video_settings.label_fullscreen:CenterY()
  video_settings.checkbox_fullscreen = loveframes.Create("checkbox", video_settings.panel_fullscreen)
  video_settings.checkbox_fullscreen:SetText("")
  video_settings.checkbox_fullscreen:SetSize(90, 25)
  video_settings.checkbox_fullscreen:SetPos(90, 0)
  video_settings.list:AddItem(video_settings.panel_fullscreen)
  
  -- Vsync X
  video_settings.panel_vsync = loveframes.Create("panel")
  video_settings.panel_vsync:SetSize(180, 25)
  video_settings.label_vsync = loveframes.Create("text", video_settings.panel_vsync)
  video_settings.label_vsync:SetText("Vsync")
  video_settings.label_vsync:SetSize(90, 25)
  video_settings.label_vsync:SetX(5)
  video_settings.label_vsync:CenterY()
  video_settings.checkbox_vsync = loveframes.Create("checkbox", video_settings.panel_vsync)
  video_settings.checkbox_vsync:SetText("")
  video_settings.checkbox_vsync:SetSize(90, 25)
  video_settings.checkbox_vsync:SetPos(90, 0)
  video_settings.list:AddItem(video_settings.panel_vsync)
  
  -- FSAA [int]
  video_settings.panel_fsaa = loveframes.Create("panel")
  video_settings.panel_fsaa:SetSize(180, 25)
  video_settings.label_fsaa = loveframes.Create("text", video_settings.panel_fsaa)
  video_settings.label_fsaa:SetText("FSAA")
  video_settings.label_fsaa:SetSize(90, 25)
  video_settings.label_fsaa:SetX(5)
  video_settings.label_fsaa:CenterY()
  video_settings.checkbox_fsaa = loveframes.Create("checkbox", video_settings.panel_fsaa)
  video_settings.checkbox_fsaa:SetText("")
  video_settings.checkbox_fsaa:SetSize(90, 25)
  video_settings.checkbox_fsaa:SetPos(90, 0)
  video_settings.list:AddItem(video_settings.panel_fsaa)
  
  -- Display [int]
  video_settings.panel_display = loveframes.Create("panel")
  video_settings.panel_display:SetSize(180, 25)
  video_settings.label_display = loveframes.Create("text", video_settings.panel_display)
  video_settings.label_display:SetText("display")
  video_settings.label_display:SetSize(90, 25)
  video_settings.label_display:SetX(5)
  video_settings.label_display:CenterY()
  video_settings.checkbox_display = loveframes.Create("checkbox", video_settings.panel_display)
  video_settings.checkbox_display:SetText("")
  video_settings.checkbox_display:SetSize(90, 25)
  video_settings.checkbox_display:SetPos(90, 0)
  video_settings.list:AddItem(video_settings.panel_display)
  
  -- HighDPI x
  video_settings.panel_highdpi = loveframes.Create("panel")
  video_settings.panel_highdpi:SetSize(180, 25)
  video_settings.label_highdpi = loveframes.Create("text", video_settings.panel_highdpi)
  video_settings.label_highdpi:SetText("highdpi")
  video_settings.label_highdpi:SetSize(90, 25)
  video_settings.label_highdpi:SetX(5)
  video_settings.label_highdpi:CenterY()
  video_settings.checkbox_highdpi = loveframes.Create("checkbox", video_settings.panel_highdpi)
  video_settings.checkbox_highdpi:SetText("")
  video_settings.checkbox_highdpi:SetSize(90, 25)
  video_settings.checkbox_highdpi:SetPos(90, 0)
  video_settings.list:AddItem(video_settings.panel_highdpi)
  
  -- sRGB x
  video_settings.panel_srgb = loveframes.Create("panel")
  video_settings.panel_srgb:SetSize(180, 25)
  video_settings.label_srgb = loveframes.Create("text", video_settings.panel_srgb)
  video_settings.label_srgb:SetText("srgb")
  video_settings.label_srgb:SetSize(90, 25)
  video_settings.label_srgb:SetX(5)
  video_settings.label_srgb:CenterY()
  video_settings.checkbox_srgb = loveframes.Create("checkbox", video_settings.panel_srgb)
  video_settings.checkbox_srgb:SetText("")
  video_settings.checkbox_srgb:SetSize(90, 25)
  video_settings.checkbox_srgb:SetPos(90, 0)
  video_settings.list:AddItem(video_settings.panel_srgb)
end

function video_settings.ToggleVisible()
  video_settings.frame.visible = not video_settings.frame.visible
end
  