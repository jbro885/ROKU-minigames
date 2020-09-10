function GetGameTwoMediator()
    if (m._gameTwoMediator = invalid)
        prototype = GetBaseMediator()

        prototype.createView = function(parrentNode)
            m._gameView = parrentNode.CreateChild("GameTwoMainView")
            m._gameView.observeField("backToMainMenu", "onBackToMainMenuHandled")
        end function

        prototype.startGame = function(gameData)
            m._gameView.content = gameData
        end function    
     

        m._gameTwoMediator = prototype
    end if
    
    return m._gameTwoMediator
end function
