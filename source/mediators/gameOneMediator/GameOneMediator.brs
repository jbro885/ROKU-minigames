function GetGameOneMediator()
    if (m._gameOneMediator = invalid)
        prototype = GetBaseMediator()

        prototype.createView = function(parrentNode)
            m._gameView = parrentNode.CreateChild("GameOneMainView")
            m._gameView.observeField("backToMainMenu", "onBackToMainMenuHandled")
        end function

        prototype.startGame = function()
            m._gameView.draw = true
        end function     

        m._gameOneMediator = prototype
    end if
    
    return m._gameOneMediator
end function
