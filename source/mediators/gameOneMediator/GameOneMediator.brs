function GetGameOneMediator()
    if (m._gameOneMediator = invalid)
        prototype = EventDispatcher()
        prototype.eventTypes = GetEventType()

        prototype.createView = function(parrentNode)
            m._gameView = parrentNode.CreateChild("GameOneMainView")
            m._gameView.observeField("backToMainMenu", "onBackToMainMenuHandled")
        end function

        prototype.startGame = function()
            m._gameView.draw = true
        end function    
        
        prototype._backToMainMenuHandled = function()
            m._gameView = invalid
            m.dispatchEvent(m.eventTypes.ON_BACK_TO_MAIN_MENU)
        end function    

        m._gameOneMediator = prototype
    end if
    
    return m._gameOneMediator
end function

function onBackToMainMenuHandled()
    m._gameOneMediator._backToMainMenuHandled()
end function    