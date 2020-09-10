function GetGameTwoMediator()
    if (m._gameTwoMediator = invalid)
        prototype = EventDispatcher()
        prototype.eventTypes = GetEventType()

        prototype.createView = function(parrentNode)
            m._gameView = parrentNode.CreateChild("GameTwoMainView")
            m._gameView.observeField("backToMainMenu", "onBackToMainMenuHandled")
        end function

        prototype.startGame = function(gameData)
            m._gameView.content = gameData
        end function    
        
        prototype._backToMainMenuHandled = function()
            m._gameView = invalid
            m.dispatchEvent(m.eventTypes.ON_BACK_TO_MAIN_MENU)
        end function    

        m._gameTwoMediator = prototype
    end if
    
    return m._gameTwoMediator
end function

' function onBackToMainMenuHandled()
'     m._gameOneMediator._backToMainMenuHandled()
' end function    