function GetGameDataService() as Object
    if (m._gameDataServiceSingleton = Invalid)
        prototype = EventDispatcher()
        prototype.eventType = GetEventType()

        prototype.loadData = function(url = invalid)
            if (url <> invalid)
                loadDataRequest = createObject("roSGNode", "RequestTask")
                loadDataRequest.observeField("response", "onDataResponse")
                loadDataRequest.observeField("error", "onDataError")
                loadDataRequest.url = url
                loadDataRequest.control = "RUN"
            else
                loadDataRequest = createObject("roSGNode", "LoadLocalData")
                loadDataRequest.observeField("filedata", "onDataResponse")
                loadDataRequest.observeField("error", "onDataError")
                loadDataRequest.filepath = "pkg:/resources/gameData/gameData.json"
                loadDataRequest.control="RUN"
            end if        
        end function   

        prototype._onDataResponce = function(payload)
            m.dispatchEvent(m.eventType.ON_GAME_DATA_REQUEST_SUCCESS, payload)
        end function    

        m._gameDataServiceSingleton = prototype 
    end if  

    return m._gameDataServiceSingleton
  end function

function onDataResponse(data)
   payload = data.getData() 
   m._gameDataServiceSingleton._onDataResponce(payload)
end function  


  
  