function GetGameModel () as Object

    if (m._accountModelSingleton = Invalid)
      prototype = EventDispatcher()
      
      prototype._currentGameId = ""

      prototype.setCurrentGameId = function(id)
          m._currentGameId = id
      end function 
      
      prototype.getCurrentGameData = function()
        return m._currentGameId
      end function  

      m._accountModelSingleton = prototype
    end if
  
    return m._accountModelSingleton
  
  end function
  