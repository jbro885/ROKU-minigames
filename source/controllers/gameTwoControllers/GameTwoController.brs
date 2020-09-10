function GetGameTwoController()
    if (m._gameTwoController = invalid)
        prototype = EventDispatcher()

        prototype.initController = function ()
            m.eventTypes = GetEventType()
            m._gameTwoMediator = GetGameTwoMediator()
        end function  

        prototype.createView = function(appContainer)
            m._gameTwoMediator.createView(appContainer)
        end function    

        prototype.start = function(gameData)
            m._gameTwoMediator.startGame(gameData)
        end function    

        m._gameTwoController = prototype
    end if
    
    return m._gameTwoController
end function