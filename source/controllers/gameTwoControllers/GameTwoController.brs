function GetGameTwoController()
    if (m._gameTwoController = invalid)
        prototype = EventDispatcher()

        prototype.initController = function ()
            m.eventTypes = GetEventType()
            m._gameTwoMediator = GetGameTwoMediator()
            m._gameTwoMediator.addEventListener(m.eventTypes.ON_BACK_TO_MAIN_MENU, "onBackToMainMenu", m)
        end function  

        prototype.createView = function(appContainer)
            m._gameTwoMediator.createView(appContainer)
        end function    

        prototype.onBackToMainMenu = function()
            m.dispatchEvent(m.eventTypes.ON_BACK_TO_MAIN_MENU)
        end function   

        prototype.start = function(gameData)
            m._gameTwoMediator.startGame(gameData)
        end function    

        m._gameTwoController = prototype
    end if
    
    return m._gameTwoController
end function