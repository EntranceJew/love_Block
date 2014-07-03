local example = {}
example.title = "Text"
example.category = "Object Demonstrations"

local loremipsum = 
[[http://nikolairesokav.com/ 
 --------------------------------------------------- 
 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean laoreet massa mattis tortor faucibus non congue mauris mattis. Aliquam ultricies scelerisque mi, sit amet tempor metus pharetra vel. Etiam eu arcu a dolor porttitor condimentum in malesuada urna. Mauris vel nulla mi, quis aliquet neque. In aliquet turpis eget purus malesuada tincidunt. Donec rutrum purus vel diam suscipit vehicula. Cras sem nibh, tempus at dictum non, consequat non justo. In sed tellus nec orci scelerisque scelerisque id vitae leo. Maecenas pharetra, nibh eget commodo gravida, augue nisl blandit dui, ut malesuada augue dui nec erat. Phasellus nec mauris pharetra metus iaculis viverra sit amet ut tortor. Duis et viverra magna. Nunc orci dolor, placerat a iaculis non, mattis sed nibh. 
 
 Mauris ac erat sit amet ante condimentum scelerisque. Cras eleifend lorem dictum mi euismod non placerat lorem gravida. Vestibulum sodales dapibus eros, non iaculis risus commodo eu. Maecenas dapibus purus accumsan metus euismod suscipit. Etiam eleifend lorem eget quam ornare interdum sed at nulla. Suspendisse viverra sapien ut felis viverra pellentesque. Ut convallis hendrerit est, in imperdiet purus placerat ut. Curabitur sapien nibh, molestie et elementum a, sagittis et tortor. Vestibulum sed quam eu velit euismod rutrum vitae et sem. Morbi accumsan quam vitae sapien scelerisque tincidunt. Nulla ipsum leo, scelerisque at consequat sit amet, venenatis eget mauris. Aliquam at nibh vel lorem hendrerit dignissim. Cras et risus sit amet est vehicula auctor at a leo. Curabitur euismod mi sit amet nunc consequat sed fringilla justo sagittis. 
 
 Nulla ut arcu felis, a laoreet tellus. Vivamus ligula nibh, bibendum ut ultrices sed, ullamcorper et est. Pellentesque nisi diam, sollicitudin lacinia fermentum quis, aliquam fermentum elit. Donec egestas vestibulum mollis. Vivamus sollicitudin nisl vestibulum nisi fermentum scelerisque. Nunc enim magna, posuere ornare faucibus a, bibendum vestibulum felis. Etiam laoreet molestie elit, vitae ultrices sem faucibus in. Fusce rutrum convallis lacus, vitae scelerisque eros tincidunt sed. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. 
 
 Quisque ornare arcu sed enim sodales dictum. Suspendisse at convallis mi. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Maecenas et nibh odio, eu lacinia lacus. Mauris at pulvinar urna. Pellentesque vel justo erat, a congue nibh. Nunc tristique mattis euismod. Suspendisse potenti. 
 
 Sed dictum faucibus cursus. Integer nisi ipsum, dapibus vel blandit laoreet, bibendum congue massa. Vestibulum tincidunt vulputate nunc, facilisis consequat lacus posuere at. Aenean sed mollis urna. Vivamus congue neque non arcu malesuada lobortis. Curabitur suscipit pretium massa eu rutrum. Nulla vehicula imperdiet dui in blandit. Curabitur vitae felis ut massa scelerisque consequat. Nulla a magna quis risus consequat hendrerit. Maecenas quis lacus sit amet ipsum condimentum interdum. Proin condimentum erat id enim elementum ut tincidunt neque vulputate.
]]

local fonts = {}
for i=10, 30 do
	fonts[i] = love.graphics.newFont(i)
end

function example.func()
	
	local frame = loveframes.Create("frame")
	frame:SetName("Text")
	frame:SetSize(500, 330)
	frame:CenterWithinArea(unpack(demo.centerarea))
	
	local list1 = loveframes.Create("list", frame)
	list1:SetPos(5, 30)
	list1:SetSize(243, 265)
	list1:SetPadding(5)
	list1:SetSpacing(5)
	
	local text1 = loveframes.Create("text")
	text1:SetLinksEnabled(true)
	text1:SetDetectLinks(true)
	text1:SetText(loremipsum)
	text1:SetShadowColor(200, 200, 200, 255)
	list1:AddItem(text1)
	
	local colortext = {}
	for i=1, 150 do
		local r = math.random(0, 255)
		local g = math.random(0, 255)
		local b = math.random(0, 255)
		table.insert(colortext, {color = {r, g, b, 255}, font = fonts[math.random(1, 30)]})
		table.insert(colortext, math.random(1, 1000) .. " ")
	end
	
	local list2 = loveframes.Create("list", frame)
	list2:SetPos(252, 30)
	list2:SetSize(243, 265)
	list2:SetPadding(5)
	list2:SetSpacing(5)
	
	local text2 = loveframes.Create("text", frame)
	text2:SetPos(255, 30)
	text2:SetLinksEnabled(true)
	text2:SetText(colortext)
	text2.OnClickLink = function(object, text)
		print(text)
	end
	list2:AddItem(text2)
	
	local shadowbutton = loveframes.Create("button", frame)
	shadowbutton:SetSize(490, 25)
	shadowbutton:SetPos(5, 300)
	shadowbutton:SetText("Toggle Text Shadow")
	shadowbutton.OnClick = function()
		text1:SetShadow(not text1:GetShadow())
		text2:SetShadow(not text2:GetShadow())
	end
	
end

demo.RegisterExample(example)