function GetGameOneController()
    if (m._gameOneController = invalid)
        prototype = EventDispatcher()

        prototype.initController = function ()
            m.eventTypes = GetEventType()
            m._gameOneMediator = GetGameOneMediator()
        end function  

        prototype.createView = function(appContainer)
            m._gameOneMediator.createView(appContainer)
        end function    

        prototype.start = function()
            m._gameOneMediator.startGame()
        end function    

        m._gameOneController = prototype
    end if
    
    return m._gameOneController
end function