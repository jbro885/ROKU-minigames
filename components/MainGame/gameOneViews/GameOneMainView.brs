function init()
    m.WIDTH_RECT_COUNT = 20 
    m.HEIGHT_RECT_COUNT = 20 
    m.top.observeField("draw", "onStartNewGame")

    m.mainGameFocus = m.top.findNode("mainGameFocus")
    m.mainGameFocus.setFocus(true)
    m.currentFocusedItemIndex = 0
    m.lastItemIndex = m.HEIGHT_RECT_COUNT  *  m.WIDTH_RECT_COUNT

    m.engineTimer = m.top.findNode("engineTimer")
    m.engineTimer.ObserveField("fire", "engineProcess")

    ' m._deviceInfo = CreateObject("roDeviceInfo")
    ' videoMode = m._deviceInfo.GetVideoMode() 
    m.animationsArray = []
    m.colorLevelArray = [
        "#003cff",
        "#00ff00",
        "#f7ff00",
        "#00ffc4",
        "#f200ff"
    ]
end function    

function setNewColorLevel(level) 
    return m.colorLevelArray[level + 1]
end function    

function onStartNewGame()
    _addGameContainers()
    buildArena()
    setItemFocus(0)
    m.engineTimer.control = "start"
end function  

function _addGameContainers()
    m.arenaContainer = createObject("roSGNode", "Group")
    m.top.appendChild(m.arenaContainer)
end function

function setItemFocus(index)
    prevFocusedItem = m.arenaContainer.getChild(m.currentFocusedItemIndex)
    focusedItem = m.arenaContainer.getChild(index)
    m.currentFocusedItemIndex = index
    prevFocusedItem.onFocus = false
    focusedItem.onFocus = true
end function    

function buildArena()
    for t = 0 to m.HEIGHT_RECT_COUNT - 1
        for i = 0 to m.WIDTH_RECT_COUNT - 1
            fieldRect = CreateObject("roSGNode", "FieldRectangle")
            rectData = CreateObject("roSGNode", "RectangleInterface")
            rectData.width = 1920 / m.WIDTH_RECT_COUNT
            rectData.height = 1080 / m.HEIGHT_RECT_COUNT
            rectData.color = "#F0F0F5"
            rectData.colorLevel = 0
            fieldRect.content = rectData
            fieldRect.translation = [rectData.width * i, rectData.height * t]
            m.arenaContainer.appendChild(fieldRect)
        end for
    end for    
end function

function createAnimation()
    finishPosition = (Fix((m.currentFocusedItemIndex + m.WIDTH_RECT_COUNT) / m.WIDTH_RECT_COUNT) * m.WIDTH_RECT_COUNT) - 1

    animationData = CreateObject("roSGNode", "AnimationInterface")
    animationData.startPosition = m.currentFocusedItemIndex
    animationData.finishPosition = finishPosition
    m.animationsArray.push(animationData)
end function 

function engineProcess()
    for i = 0 to m.animationsArray.count() - 1
        animationItem = m.animationsArray[i]
        if (animationItem <> invalid)
            arenaItem = m.arenaContainer.getChild(animationItem.startPosition)
            arenaItem.newColor = setNewColorLevel(arenaItem.colorLevel)
            arenaItem.colorLevel = arenaItem.colorLevel + 1
            if (arenaItem.colorLevel > m.colorLevelArray.count() - 1 or arenaItem.colorLevel = m.colorLevelArray.count() - 1) then arenaItem.colorLevel = 0
            if (animationItem.startPosition + 1 > animationItem.finishPosition)
                m.animationsArray.Delete(i)
            else
                animationItem.startPosition += 1
            end if    
        end if
    end for    
end function

function backToMainMenu()
    m.top.backToMainMenu = true
end function    

function onKeyEvent(key, press)
    if (press = true)
        if (key = "right")
            if (m.currentFocusedItemIndex + 1 < m.lastItemIndex) then setItemFocus(m.currentFocusedItemIndex + 1)
        else if (key ="left") 
            if (m.currentFocusedItemIndex - 1 > -1) then setItemFocus(m.currentFocusedItemIndex - 1)
        else if (key = "up")    
            if (m.currentFocusedItemIndex - m.HEIGHT_RECT_COUNT > -1) then setItemFocus(m.currentFocusedItemIndex - m.HEIGHT_RECT_COUNT)
        else if (key = "down")
            if (m.currentFocusedItemIndex + m.HEIGHT_RECT_COUNT < m.lastItemIndex) then setItemFocus(m.currentFocusedItemIndex + m.HEIGHT_RECT_COUNT)
        else if (key = "OK")
            createAnimation()
        else if (key = "back")
            backToMainMenu()
             return true   
        end if
    end if    
  return false
end function