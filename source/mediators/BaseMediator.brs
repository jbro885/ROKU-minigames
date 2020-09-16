function GetBaseMediator()
    if (m._gameBaseMediator = invalid)
        prototype = EventDispatcher()
        prototype.eventTypes = GetEventType()

        prototype._backToMainMenuHandled = function()
            m.dispatchEvent(m.eventTypes.ON_BACK_TO_MAIN_MENU)
        end function    

        m._gameBaseMediator = prototype
    end if
    
    return m._gameBaseMediator
end function

function onBackToMainMenuHandled()
    m._gameBaseMediator._backToMainMenuHandled()
end function    