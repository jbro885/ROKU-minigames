function init()
    m.top.observeField("draw", "onStartNewGame")

    m.mainGameFocus = m.top.findNode("mainGameFocus")
    m.mainGameFocus.setFocus(true)

    m.engineTimer = m.top.findNode("engineTimer")
    m.engineTimer.ObserveField("fire", "engineProcess")

    m.gameData = {walls:[ [0,0,1,0,1,1],[0,0,0,1,1,1],[1,0,1,0,1,1],[0,0,1,0,0,1],[0,1,0,0,1,1],[1,0,0,0,1,0] ]}

    ' m._deviceInfo = CreateObject("roDeviceInfo")
    ' videoMode = m._deviceInfo.GetVideoMode() 
end function       

function onStartNewGame()
    _addGameContainers()
    buildArena()
    m.engineTimer.control = "start"
end function  

function _addGameContainers()
    m.arenaContainer = createObject("roSGNode", "Group")
    m.top.appendChild(m.arenaContainer)
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

function engineProcess()

end function

function backToMainMenu()
    m.top.backToMainMenu = true
end function    

function onKeyEvent(key, press)
    if (press = true)
        if (key = "right")

        else if (key ="left") 

        else if (key = "up")    

        else if (key = "down")

        else if (key = "OK")

        else if (key = "back")
            backToMainMenu()
            return true   
        end if
    end if    
  return false
end function