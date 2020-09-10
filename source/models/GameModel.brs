function GetGameModel () as Object

    if (m._accountModelSingleton = Invalid)
      prototype = EventDispatcher()
      prototype._gameDataService = GetGameDataService()
      prototype.eventTypes = GetEventType()
      
      prototype._currentGameId = ""

      prototype._currentGameData = invalid

      prototype._requestGameData = function(id)
        if (id="gameTwo")
          m._gameDataService.loadData()
          m._gameDataService.addEventListener("ON_GAME_DATA_REQUEST_FAIL", "onGameDataFail", m)
          m._gameDataService.addEventListener("ON_GAME_DATA_REQUEST_SUCCESS", "onGameDataSuccess", m )
        else
          m.dispatchEvent(m.eventTypes.GAME_DATA_PARSED)
        end if    
      end function 
      
      prototype.onGameDataSuccess= function(payload)
        data = ParseJSON(payload)
        m.setGameData(data)
        m.dispatchEvent(m.eventTypes.GAME_DATA_PARSED)
      end function  

      prototype.setGameData = function(data)
        m._currentGameData = {
          walls: data.walls
          currentGameId: m.getCurrentGameId()
        }
      end function 
      
      prototype.getGameData = function()
        return m._currentGameData
      end function  

      prototype.onGameDataFail = function(payload)
      
      end function   

      prototype.setCurrentGameId = function(id)
          m._currentGameId = id
      end function 
      
      prototype.getCurrentGameId = function()
        return m._currentGameId
      end function  

      m._accountModelSingleton = prototype
    end if
  
    return m._accountModelSingleton
  
  end function
  