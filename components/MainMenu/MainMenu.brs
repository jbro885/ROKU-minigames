function init()
    m.context = m.top
    m.mainMenuListContainer = m.context.findNode("MainMenuList")
    m.mainMenuListContainer.itemSize = [300, 50]
    m.mainMenuListContainer.translation = [800, 400]
    m.mainMenuListContainer.setFocus(true)
end function

function onKeyEvent(key, press)
    if (key = "OK" and press)
        changeMenuState()
    end if
  return false
end function

function onContentUpdate()
    m.content = m.top.content
    if (m.content.viewType = "MAIN_MENU_TYPE")
        mainMenuListContent = CreateObject("roSGNode", "ContentNode")

        gameOneTextContent = CreateObject("roSGNode", "ContentNode")
        gameOneTextContent.title = "Game One"
        gameOneTextContent.id = "gameOne"
        mainMenuListContent.appendChild(gameOneTextContent)

        gameTwoTextContent = CreateObject("roSGNode", "ContentNode")
        gameTwoTextContent.title = "Game Two"
        gameTwoTextContent.id = "gameTwo"
        mainMenuListContent.appendChild(gameTwoTextContent)

        m.mainMenuListContainer.content = mainMenuListContent 
    else if (m.content.viewType = "GAME_MENU_TYPE")   
        mainMenuListContent = CreateObject("roSGNode", "ContentNode")

        newGameLabel = CreateObject("roSGNode", "ContentNode")
        newGameLabel.title = "New Game"
        newGameLabel.id = "newGame"
        mainMenuListContent.appendChild(newGameLabel)

        m.mainMenuListContainer.content = mainMenuListContent 
    end if    
end function    

function changeMenuState()
   selectedState = m.mainMenuListContainer.itemSelected
   if (m.content.viewType = "MAIN_MENU_TYPE")
      m.top.selectedGame = m.mainMenuListContainer.content.getChild(selectedState).id
   else if (m.content.viewType = "GAME_MENU_TYPE")
      m.top.selectedMenuState = m.mainMenuListContainer.content.getChild(selectedState).id
   end if 
end function