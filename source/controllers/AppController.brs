function GetAppController()

    if (m._appController = invalid)
        prototype = EventDispatcher()

        prototype.eventTypes = GetEventType()

        prototype.initApp = function()
            m.mainMenuController = GetMainMenuController()
            m.gameModel = GetGameModel()
            m.gameOneController = GetGameOneController()
            m.gameTwoController = GetGameTwoController()
        end function
        
        prototype.startApp = function(mainContainer)
            m.appContainer = mainContainer
            m._showMainMenu()
        end function

        prototype._showMainMenu = function()
            m.mainMenuController.initController()
            m.mainMenuController.createMainMenuView(m.appContainer)

            m.mainMenuController.addEventListener(m.eventTypes.START_GAME_PRESSED, "_onStartNewGameHandled", m)
            m.mainMenuController.addEventListener(m.eventTypes.SETTINGS_PRESSED, "_onSettingsHandled", m)
            m.mainMenuController.addEventListener(m.eventTypes.EXIT_PRESSED, "_onExitHandled", m)
        end function

        prototype._clearMainView = function()
            m.appContainer.removeChildIndex(m.appContainer.getChildCount() - 1)
        end function    

        prototype._onStartNewGameHandled= function()
            m.mainMenuController.removeEventListener(m.eventTypes.START_GAME_PRESSED, "_onStartNewGameHandled", m)
            m.mainMenuController.removeEventListener(m.eventTypes.SETTINGS_PRESSED, "_onSettingsHandled", m)
            m.mainMenuController.removeEventListener(m.eventTypes.EXIT_PRESSED, "_onExitHandled", m)

            m._clearMainView()

            currentGameData = m.gameModel.getCurrentGameData()
            if (currentGameData = "gameOne")
                m.gameOneController.initController()
                m.gameOneController.createView(m.appContainer)
                m.gameOneController.start()
            else if (currentGameData = "gameTwo")   
                m.gameTwoController.initController()
                m.gameTwoController.createView(m.appContainer)
                m.gameTwoController.start()
            end if    
        end function

        m._appController = prototype
    end if
    
    return m._appController
end function