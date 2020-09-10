function GetGameOneController()
    if (m._gameOneController = invalid)
        prototype = EventDispatcher()

        prototype.initController = function ()
            m.eventTypes = GetEventType()
            m._gameOneMediator = GetGameOneMediator()
            m._gameOneMediator.addEventListener(m.eventTypes.ON_BACK_TO_MAIN_MENU, "onBackToMainMenu", m)
        end function  

        prototype.createView = function(appContainer)
            m._gameOneMediator.createView(appContainer)
        end function    

        prototype.onBackToMainMenu = function()
            m.dispatchEvent(m.eventTypes.ON_BACK_TO_MAIN_MENU)
        end function    

        prototype.start = function()
            m._gameOneMediator.startGame()
        end function    

        m._gameOneController = prototype
    end if
    
    return m._gameOneController
end function