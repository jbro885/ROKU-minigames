function init()
    m.mainGameFocus = m.top.findNode("mainGameFocus")
    m.mainGameFocus.setFocus(true)
    m.engineTimer = m.top.findNode("engineTimer")
    m.engineTimer.ObserveField("fire", "engineProcess")

    m.isPress = false
    m.neighborArray = []
    m.startPosition = []
    ' m._deviceInfo = CreateObject("roDeviceInfo")
    ' videoMode = m._deviceInfo.GetVideoMode() 
end function       

function onContentUpdate()
    m.gameData = m.top.content
    _addGameContainers()

    buildArena()
    calculateShortestPath()
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

function calculateShortestPath()
    wayItemsArray = []
    shortestWay  = []
    currentPlace = 0
    minimalWeight = 0
    rowsCount = m.gameData.walls.count() - 1
    for i = 0 to m.arenaContainer.getChildCount() - 1
        item = m.arenaContainer.getChild(i)
        if (item.content.itemType = "way" and item.content.neighbors.count() > 0)
            wayItemsArray.push(i)
        end if
    end for
    arrayOfVisitedTiles = []
    m.arenaContainer.getChild(0).weight = Str(minimalWeight)

    if (m.startPosition.count() = 0)
        m.startPosition = [0]
    end if
    neighborsAray = []
    visitedArray = [0]
    startPosition = [0]
    wayItemsArray.Delete(0)
    while wayItemsArray.count() > 0
        arayOfNewStartPositions = []
        for each startPositionItem in startPosition
            arenaItem = m.arenaContainer.getChild(startPositionItem)
            for each item in arenaItem.content.neighbors
                neighborItem = m.arenaContainer.getChild(item)
                if (findInVisitArray(visitedArray, item) = false)
                    neighborItem.weight = minimalWeight + 1
                    neighborItem.weightInt = minimalWeight + 1
                    visitedArray.push(item)
                    arayOfNewStartPositions.push(item)
                    for i = 0 to wayItemsArray.count() - 1
                        if (wayItemsArray[i] = item)
                            wayItemsArray.Delete(i)
                            exit for
                        end if    
                    end for    
                end if  
            end for
        end for    
        minimalWeight = minimalWeight + 1
        startPosition = arayOfNewStartPositions 
        if (wayItemsArray.count() = 0)
            exit while
        end if    
    end while 

    findWay()

end function  

function findWay()
    maxWeight = 10
    arayPath = []
    maxCountRevers = (m.arenaContainer.getChildCount() - 1) * -1
    while maxWeight > 0
        for i = maxCountRevers to 0
            item = m.arenaContainer.getChild(i * -1)
            if (item.weightInt = maxWeight)
                arayPath.push(i * -1)
                maxWeight = maxWeight -1
                exit for
            end if
        end for
    end while  
end function

function findInVisitArray(visitedArray, neighborItem)
    if (visitedArray.count() > 0)
        for each item in visitedArray
            if (item = neighborItem)
                return true
                exit for
            end if    
        end for
        return false
    end if 
    return false
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
            if (m.character.translation[1] > 1000)
                m.isPress = false
                return true
            end if
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
        checkForWin()
    
        m.character.direction = m.pressedKey
    end if
end function

function checkForWin()
    characterX = m.character.translation[0]
    characterY = m.character.translation[1]
    lastAsset = m.arenaContainer.getChild(m.arenaContainer.getChildCount() - 1)
    if ((characterX = lastAsset.translation[0] or characterX > lastAsset.translation[0]) and (characterY = lastAsset.translation[1] or characterY > lastAsset.translation[1])) 
        m.character.translation= [0 , 0]
        backToMainMenu()
    end if
end function    

function calculateNeighbors(wallsData, currentBlockX, currentBlockY)
    neighbors = []
    rowsCount = wallsData.count()
    currentXYPosition = (currentBlockY * rowsCount) + currentBlockX
    if (currentBlockY - 1 > -1 and wallsData[currentBlockY - 1][currentBlockX] <> 1)
        neighbors.push(currentXYPosition - rowsCount)
    end if    
    if (currentBlockX - 1 > -1 and wallsData[currentBlockY][currentBlockX - 1] <> 1)
        neighbors.push(currentXYPosition - 1)
    end if    
    if (currentBlockX + 1 <= wallsData[currentBlockY].count() - 1 and wallsData[currentBlockY][currentBlockX + 1] <> 1)
        neighbors.push(currentXYPosition + 1)
    end if 
    if (currentBlockY + 1 <= rowsCount - 1 and wallsData[currentBlockY + 1][currentBlockX] <> 1)
        neighbors.push(currentXYPosition + rowsCount)
    end if 
    
    return neighbors
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
                arenaItemData.neighbors = calculateNeighbors(m.gameData.walls, i, t)
                for each neighbor in arenaItemData.neighbors
                    m.neighborArray.push(neighbor)
                end for    
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