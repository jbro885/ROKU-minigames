function GetAppController()

    if (m._appController = invalid)
        prototype = {}


        prototype.eventTypes = GetEventType()

        prototype.startApp = function(mainContainer)
            m.appContainer = mainContainer
            m._showMainMenu()
        end function

        m._appController = prototype
    end if
    
    return m._appController
end function