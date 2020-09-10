function GetAppController()

    if (m._appController = invalid)
        prototype = EventDispatcher()

        prototype.eventTypes = GetEventType()

        prototype.initApp = function()
            m.mainMenuController = GetMainMenuController()
            m.gameModel = GetGameModel()
            m.gameController = GetGameTwoController()
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

        prototype._backToMainMenuHandled = function()
            m.gameController.removeEventListener(m.eventTypes.ON_BACK_TO_MAIN_MENU, "_onExitHandled", m)
            m._clearMainView()
            m._showMainMenu()
        end function    

        prototype._clearMainView = function()
            m.appContainer.removeChildIndex(m.appContainer.getChildCount() - 1)
        end function    

        prototype._onStartNewGameHandled= function()
            m.mainMenuController.removeEventListener(m.eventTypes.START_GAME_PRESSED, "_onStartNewGameHandled", m)
            m.mainMenuController.removeEventListener(m.eventTypes.SETTINGS_PRESSED, "_onSettingsHandled", m)
            m.mainMenuController.removeEventListener(m.eventTypes.EXIT_PRESSED, "_onExitHandled", m)

            m._clearMainView()

            currentGameId = m.gameModel.getCurrentGameId()
            m.gameModel.addEventListener(m.eventTypes.GAME_DATA_PARSED, "_onGameDataParsedStartGame", m)
            m.gameModel._requestGameData(currentGameId)

        end function

        prototype._onGameDataParsedStartGame = function()
            gameData = m.gameModel.getGameData()
            gameId = ""
            if (gameData = invalid)
                gameId = m.gameModel.getCurrentGameId()
            end if    
            if (gameData <> invalid and gameData.currentgameid = "gameOne" or gameId = "gameOne")
                m.gameController = GetGameOneController()
                m.gameController.initController()
                m.gameController.createView(m.appContainer)
                m.gameController.start()
                m.gameController.addEventListener(m.eventTypes.ON_BACK_TO_MAIN_MENU, "_backToMainMenuHandled", m)
            else if (gameData.currentgameid = "gameTwo")  
                m.gameController = GetGameTwoController() 
                m.gameController.initController()
                m.gameController.createView(m.appContainer)
                m.gameController.start(gameData)
                m.gameController.addEventListener(m.eventTypes.ON_BACK_TO_MAIN_MENU, "_backToMainMenuHandled", m)
            end if    
        end function   
            
        m._appController = prototype
    end if
    
    return m._appController
end function