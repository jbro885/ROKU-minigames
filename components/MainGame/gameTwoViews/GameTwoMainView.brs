function init()
    m.mainGameFocus = m.top.findNode("mainGameFocus")
    m.mainGameFocus.setFocus(true)
    m.engineTimer = m.top.findNode("engineTimer")
    m.engineTimer.ObserveField("fire", "engineProcess")

    m.isPress = false
    ' m._deviceInfo = CreateObject("roDeviceInfo")
    ' videoMode = m._deviceInfo.GetVideoMode() 
end function       

function onContentUpdate()
    m.gameData = m.top.content
    _addGameContainers()

    buildArena()
    createCharacter()
    m.engineTimer.control = "start"
end function  

function _addGameContainers()
    m.arenaContainer = createObject("roSGNode", "Group")
    m.top.appendChild(m.arenaContainer)
end function  

function calculateCharacterSize()
    characterSize = 0
    arenaItemHeight = m.arenaContainer.getChild(0).content.height
    arenaItemWeigth = m.arenaContainer.getChild(0).content.width
    if (arenaItemHeight < arenaItemWeigth)
        characterSize = arenaItemHeight / 2
    else
        characterSize = arenaItemWeigth / 2
    end if    
    return characterSize
end function

function createCharacter()
    m.character = createObject("roSGNode", "PlayerCharacter")
    m.character.translation = [0, 0]
    m.character.speed = 20
    m.character.size = calculateCharacterSize()
    m.character.direction = "down"
    m.top.appendChild(m.character)
    m.character.setFocus(true)
end function

function playerMovement()
    if (m.isPress)
        if (m.pressedKey = "right" )
            if (checkCharactersColision([m.character.translation[0] + m.character.speed, m.character.translation[1]]))
                m.character.translation = [m.character.translation[0] + m.character.speed, m.character.translation[1]]
            end if    

        else if (m.pressedKey = "down" and checkCharactersColision([m.character.translation[0], m.character.translation[1]  + m.character.speed]))
            m.character.translation = [m.character.translation[0], m.character.translation[1]  + m.character.speed]
        else if (m.pressedKey = "left" and checkCharactersColision([m.character.translation[0] - m.character.speed, m.character.translation[1]]))
            if (m.character.translation[0] < 0)
                m.isPress = false
                return true
            end if
            m.character.translation = [m.character.translation[0] - m.character.speed, m.character.translation[1]]
        else if (m.pressedKey = "up" and checkCharactersColision([m.character.translation[0], m.character.translation[1] - m.character.speed]))
            if (m.character.translation[1] < 0)
                m.isPress = false
                return true
            end if
            m.character.translation = [m.character.translation[0], m.character.translation[1] - m.character.speed]
        end if
        m.character.direction = m.pressedKey
    end if
end function

function buildArena()
    for t = 0 to m.gameData.walls.count() - 1
        for i = 0 to m.gameData.walls[t].count() - 1
            wallItem = m.gameData.walls[t][i]
            arenaItem = CreateObject("roSGNode", "ArenaItem")
            arenaItemData = CreateObject("roSGNode", "ArenaItemInterface")
            arenaItemData.width = 1920 / m.gameData.walls.count() - 1
            arenaItemData.height = 1080 / m.gameData.walls[t].count() - 1
            arenaItem.translation = [arenaItemData.width * i, arenaItemData.height * t]
            if (wallItem = 1)
                arenaItemData.itemType = "wall"
            else
                arenaItemData.itemType = "way"
            end if        
            arenaItem.content = arenaItemData
            m.arenaContainer.appendChild(arenaItem)
        end for
    end for    
end function

function checkCharactersColision(nextStep)
    characterMinXPosition = (nextStep[0] - m.character.size / 2) - 15
    characterMaxXPosition = (nextStep[0] + m.character.size / 2) - 15
    characterMinYPosition = (nextStep[1] - m.character.size / 2) - 15
    characterMaxYPosition = (nextStep[1] + m.character.size / 2) - 15
    for i = 0 to m.arenaContainer.getChildCount() - 1
        if (m.arenaContainer.getChild(i).content.itemType = "wall")   
            wall = m.arenaContainer.getChild(i)
            wallMinXPosition = wall.translation[0] - m.character.size / 2
            wallMaxXPosition = wall.translation[0] + wall.content.width / 2 + m.character.size / 2
            wallMinYPosition = wall.translation[1] - m.character.size / 2
            wallMaxYPosition = wall.translation[1] + wall.content.height / 2
            if ((wallMaxXPosition > characterMinXPosition and wallMaxXPosition < characterMaxXPosition) and (characterMaxYPosition > wallMinYPosition and characterMinYPosition < wallMaxYPosition ))
               return false
            else if ((characterMaxXPosition > wallMinXPosition and characterMinXPosition < wallMaxXPosition ) and (characterMaxYPosition > wallMinYPosition and characterMinYPosition < wallMaxYPosition ))    
                return false
            end if
        end if
    end for
    return true
end function

function engineProcess()
    playerMovement()
end function

function backToMainMenu()
    m.top.backToMainMenu = true
end function    

function onKeyEvent(key, press)
    if (key = "right" or key = "left" or key = "up" or key = "down")
        m.isPress = press
        m.pressedKey = key
    else if (key = "back")
        backToMainMenu()
        return true   
    end if  
  return false
end function