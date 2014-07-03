local example = {}
example.title = "HTTP request"
example.category = "Example Implementations"

function example.func()
	
	local headers = {}
	
	local frame = loveframes.Create("frame")
	frame:SetName("HTTP Request")
	frame:SetSize(500, 365)
	frame:CenterWithinArea(unpack(demo.centerarea))
	
	local resultpanel = loveframes.Create("panel", frame)
	resultpanel:SetPos(5, 30)
	resultpanel:SetSize(490, 25)
	
	local headersbutton = loveframes.Create("button", resultpanel)
	headersbutton:SetPos(390, 0)
	headersbutton:SetSize(100, 25)
	headersbutton:SetText("View Headers")
	headersbutton:SetVisible(false)
	headersbutton.OnClick = function(object)
		local headersframe = loveframes.Create("frame")
		headersframe:SetName("Headers")
		headersframe:SetSize(400, 200)
		headersframe:CenterWithinArea(unpack(demo.centerarea))
		local headerslist = loveframes.Create("columnlist", headersframe)
		headerslist:SetPos(5, 30)
		headerslist:SetSize(390, 165)
		headerslist:AddColumn("Name")
		headerslist:AddColumn("Value")
		for k, v in pairs(headers) do
			headerslist:AddRow(k, v)
		end
	end
	
	local resulttext = loveframes.Create("text", resultpanel)
	resulttext:SetPos(5, 5)
	
	local resultinput = loveframes.Create("textinput", frame)
	resultinput:SetPos(5, 60)
	resultinput:SetWidth(490)
	resultinput:SetMultiline(true)
	resultinput:SetHeight(270)
	resultinput:SetEditable(false)
	
	local urlinput = loveframes.Create("textinput", frame)
	urlinput:SetSize(387, 25)
	urlinput:SetPos(5, 335)
	urlinput:SetText("http://love2d.org")
	
	local httpbutton = loveframes.Create("button", frame)
	httpbutton:SetSize(100, 25)
	httpbutton:SetPos(frame:GetWidth() - 105, 335)
	httpbutton:SetText("Send Request")
	httpbutton.OnClick = function()
		local url = urlinput:GetValue()
		local http = require("socket.http")
		local b, c, h = http.request(url)
		if b then
			resulttext:SetText("Response code: " ..c)
			resulttext:CenterY()
			resultinput:SetText(b)
			resultinput:SetFocus(true)
			headersbutton:SetVisible(true)
			headers = h
		else
			resultinput:SetText("Error: HTTP request returned a nil value.")
		end
	end
	
end

demo.RegisterExample(example)