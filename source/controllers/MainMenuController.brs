function GetMainMenuController()

    if (m._mainMenuController = invalid)
        prototype = EventDispatcher()

        prototype.initController = function ()
            m._mainMenuMediator = GetMainMenuMediator()
            m._gameModel = GetGameModel()
            m.eventTypes = GetEventType()
        end function  
        
        prototype.createMainMenuView = function(appContainer)
            m._mainMenuMediator.createView(appContainer)
            m._mainMenuMediator.setViewType(m._mainMenuMediator.MAIN_MENU_TYPE)
            m._mainMenuMediator.addEventListener(m.eventTypes.ON_GAME_SELECTED, "_onGameSelected", m)

            m._mainMenuMediator.addEventListener(m.eventTypes.ON_SET_MENU_STATE, "_onSetMenuStateHandled", m)
        end function    

        prototype._onGameSelected = function(payload)
            m._mainMenuMediator.removeEventListener(m.eventTypes.ON_GAME_SELECTED, "onGameSelected", m)
            m._gameModel.setCurrentGameId(payload)
            m._mainMenuMediator.setViewType(m._mainMenuMediator.GAME_MENU_TYPE)
        end function

        prototype._onSetMenuStateHandled = function(payload)
            if (payload = "newGame")
                m.dispatchEvent(m.eventTypes.START_GAME_PRESSED)
            else if (payload = "settings") 
                m.dispatchEvent(m.eventTypes.SETTINGS_PRESSED)
            else if (payload = "exit") 
                m.dispatchEvent(m.eventTypes.EXIT_PRESSED)
            end if    
        end function    

        m._mainMenuController = prototype
    end if
    
    return m._mainMenuController
end function