not_implemented = {}

function not_implemented.func()
  not_implemented.frame = loveframes.Create("frame")
  not_implemented.frame.visible = false
	not_implemented.frame:SetName("SORRY NOTHING")
	not_implemented.frame:CenterWithinArea(unpack({5, 40, 540, 555}))
  not_implemented.frame.OnClose = function(object)
    not_implemented.func()
  end
	
	not_implemented.text = loveframes.Create("text", not_implemented.frame)
	not_implemented.text:SetText("This feature isn't implemented yet.\nTry again later.")
	not_implemented.text:Center()
end

function not_implemented.ToggleVisible()
  not_implemented.frame.visible = not not_implemented.frame.visible
end