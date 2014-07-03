local example = {}
example.title = "List"
example.category = "Object Demonstrations"

local font = love.graphics.newFont(10)

function example.func()
	
	local frame = loveframes.Create("frame")
	frame:SetName("List")
	frame:SetSize(500, 470)
	frame:CenterWithinArea(unpack(demo.centerarea))
		
	local list = loveframes.Create("list", frame)
	list:SetPos(5, 30)
	list:SetSize(490, 300)
	list:SetPadding(5)
	list:SetSpacing(5)
	
	local panel = loveframes.Create("panel")
	panel:SetSize(490, 115)
	panel.Draw = function() end
	
	local text1 = loveframes.Create("text", panel)
	local text2 = loveframes.Create("text", panel)
	local slider1 = loveframes.Create("slider", panel)
	slider1:SetPos(5, 20)
	slider1:SetWidth(480)
	slider1:SetMinMax(0, 100)
	slider1:SetValue(5)
	slider1:SetText("Padding")
	slider1:SetDecimals(0)
	slider1.OnValueChanged = function(object2, value)
		list:SetPadding(value)
		text2:SetPos(slider1:GetWidth() - text2:GetWidth(), 5)
		text2:SetText(slider1:GetValue())
	end
		
	text1:SetPos(5, 5)
	text1:SetFont(font)
	text1:SetText(slider1:GetText())
	
	text2:SetText(slider1:GetValue())
	text2:SetFont(font)
	text2:SetPos(slider1:GetWidth() - text2:GetWidth(), 5)
	
	local text3 = loveframes.Create("text", panel)
	local text4 = loveframes.Create("text", panel)
	local slider2 = loveframes.Create("slider", panel)
	slider2:SetPos(5, 60)
	slider2:SetWidth(480)
	slider2:SetMinMax(0, 100)
	slider2:SetValue(5)
	slider2:SetText("Spacing")
	slider2:SetDecimals(0)
	slider2.OnValueChanged = function(object2, value)
		list:SetSpacing(value)
		text4:SetPos(slider2:GetWidth() - text4:GetWidth(), 45)
		text4:SetText(slider2:GetValue())
	end
		
	text3:SetPos(5, 45)
	text3:SetFont(font)
	text3:SetText(slider2:GetText())
	
	text4:SetText(slider2:GetValue())
	text4:SetFont(font)
	text4:SetPos(slider2:GetWidth() - text4:GetWidth(), 45)
	
	local button1 = loveframes.Create("button", panel)
	button1:SetPos(5, 85)
	button1:SetSize(237, 25)
	button1:SetText("Change List Type")
	button1.OnClick = function(object2, x, y)
		if list:GetDisplayType() == "vertical" then
			list:SetDisplayType("horizontal")
		else
			list:SetDisplayType("vertical")
		end
		list:Clear()
		for i=1, 100 do
			local button = loveframes.Create("button")
			button:SetText(i)
			list:AddItem(button)
		end
	end
		
	local button2 = loveframes.Create("button", panel)
	button2:SetPos(247, 85)
	button2:SetSize(237, 25)
	button2:SetText("Toggle Horizontal Stacking")
	button2.OnClick = function(object2, x, y)
		local enabled = list:GetHorizontalStacking()
		list:EnableHorizontalStacking(not enabled)
		list:Clear()
		for i=1, 100 do
			local button = loveframes.Create("button")
			button:SetSize(100, 25)
			button:SetText(i)
			list:AddItem(button)
		end
	end
	button2.Update = function(object)
	local displaytype = list:GetDisplayType()
		if displaytype ~= "vertical" then
			object:SetEnabled(false)
			object:SetClickable(false)
		else
			object:SetEnabled(true)
			object:SetClickable(true)
		end
	end
	
	local form = loveframes.Create("form", frame)
	form:SetPos(5, 335)
	form.padding = 0
	form.spacing = 0
	form:SetName("List Controls")
	form:AddItem(panel)
	
	for i=1, 100 do
		local button = loveframes.Create("button")
		button:SetText(i)
		list:AddItem(button)
	end
	
end

demo.RegisterExample(example)