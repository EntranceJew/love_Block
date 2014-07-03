local example = {}
example.title = "Form"
example.category = "Object Demonstrations"

function example.func()
	
	local frame = loveframes.Create("frame")
	frame:SetName("Form")
	frame:SetSize(500, 80)
	frame:CenterWithinArea(unpack(demo.centerarea))
		
	local form = loveframes.Create("form", frame)
	form:SetPos(5, 25)
	form:SetSize(490, 65)
	form:SetLayoutType("horizontal")
	
	for i=1, 3 do
		local button = loveframes.Create("button")
		button:SetText(i)
		button:SetWidth((490/3) - 7)
		form:AddItem(button)
	end
	
end

demo.RegisterExample(example)