function GetMainMenuMediator()
    if (m._mainMenuMediator = invalid)
        prototype = EventDispatcher()

        prototype.MAIN_MENU_TYPE = "MAIN_MENU_TYPE"
        prototype.GAME_MENU_TYPE = "GAME_MENU_TYPE"

        prototype.eventTypes = GetEventType()

        prototype.createView = function (parentNode)
            m.mainMenuView =  parentNode.CreateChild("MainMenu")
            m.mainMenuView.observeField("selectedGame", "onGameSelected")
            m.mainMenuView.observeField("selectedMenuState", "onMenuStateChanged")
        end function

        prototype.setViewType = function (viewType as string)
            m.mainMenuView.content = {viewType: viewType}
        end function    

        prototype._onGameSelected = function()
            m.dispatchEvent(m.eventTypes.ON_GAME_SELECTED, m.mainMenuView.selectedGame)
        end function    

        prototype._onMenuStateChanged = function()
            m.dispatchEvent(m.eventTypes.ON_SET_MENU_STATE,  m.mainMenuView.selectedMenuState)      
        end function

        m._mainMenuMediator = prototype
    end if
    
    return m._mainMenuMediator
end function

function onGameSelected()
    m._mainMenuMediator._onGameSelected()
end function  

function onMenuStateChanged()
    m._mainMenuMediator._onMenuStateChanged()
end function    