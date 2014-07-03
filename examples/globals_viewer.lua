local example = {}
example.title = "Globals Viewer"
example.category = "Example Implementations"

function example.func()
	
	local frame = loveframes.Create("frame")
	frame:SetName("Globals Viewer")
	frame:SetSize(500, 300)
	frame:CenterWithinArea(unpack(demo.centerarea))
	
	local glist = loveframes.Create("columnlist", frame)
	glist:SetPos(5, 30)
	glist:SetSize(490, 265)
	glist:AddColumn("Key")
	glist:AddColumn("Value")
	
	for k, v in pairs(_G) do
		local value_str = ""
		glist:AddRow(k, tostring(v))
	end
	
end

demo.RegisterExample(example)