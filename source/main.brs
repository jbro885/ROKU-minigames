sub main()
	screen = createObject("roSGScreen")
	scene = screen.createScene("MainScene")
	screen.Show()
  	port = createObject("roMessagePort")
	screen.setMessagePort(m.port)
	
	while(true)

	end while
end sub