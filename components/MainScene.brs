function init()
    m.context = m.top
    m.appController = GetAppController()
    m.appController.initApp()
    m.appController.startApp(m.context)
end function