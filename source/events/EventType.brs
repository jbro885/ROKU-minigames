'//////////////////
'/// events.EventType
'//////////////////
function GetEventType() as Object
  if (m._eventTypeSingleton = Invalid)

    prototype = {}
    m._eventTypeSingleton = prototype
  end if

  return m._eventTypeSingleton
end function

function DestroyEventType () as Void
  m._eventTypeSingleton = Invalid
end function
