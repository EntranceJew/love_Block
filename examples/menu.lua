local example = {}
example.title = "Menu"
example.category = "Object Demonstrations"

function example.func()
	
	local frame = loveframes.Create("frame")
	frame:SetName("Button")
	frame:CenterWithinArea(unpack(demo.centerarea))
	frame.menu_example = true
	
	local text = loveframes.Create("text", frame)
	text:SetText("Right click this frame to see an \n example of the menu object")
	text:Center()
	
end

function createMenus(x, y)

	local submenu3 = loveframes.Create("menu")
	submenu3:AddOption("Option 1", false, function() end)
	submenu3:AddOption("Option 2", false, function() end)
		
	local submenu2 = loveframes.Create("menu")
	submenu2:AddOption("Option 1", false, function() end)
	submenu2:AddOption("Option 2", false, function() end)
	submenu2:AddOption("Option 3", false, function() end)
	submenu2:AddOption("Option 4", false, function() end)
		
	local submenu1 = loveframes.Create("menu")
	submenu1:AddSubMenu("Option 1", false, submenu3)
	submenu1:AddSubMenu("Option 2", "resources/images/brick.png", submenu2)
		
	local menu = loveframes.Create("menu")
	menu:AddOption("Option A", "resources/images/brick.png", function() end)
	menu:AddOption("Option B", "resources/images/add.png", function() end)
	menu:AddDivider()
	menu:AddOption("Option C", "resources/images/building.png", function() end)
	menu:AddOption("Option D", "resources/images/accept.png", function() end)
	menu:AddDivider()
	menu:AddSubMenu("Option E", false, submenu1)
	menu:SetPos(x, y)
		
	loveframes.hoverobject.menu = menu
	
end

demo.RegisterExample(example)