'//////////////////
'/// events.EventType
'//////////////////
function GetEventType() as Object
  if (m._eventTypeSingleton = Invalid)

    prototype = {}

    prototype.ON_GAME_SELECTED = "ON_GAME_SELECTED"

    prototype.ON_SET_MENU_STATE = "ON_SET_MENU_STATE"

    prototype.START_GAME_PRESSED = "START_GAME_PRESSED"
    prototype.SETTINGS_PRESSED = "SETTINGS_PRESSED"
    prototype.EXIT_PRESSED = "EXIT_PRESSED"

    prototype.ON_BACK_TO_MAIN_MENU = "ON_BACK_TO_MAIN_MENU"

    prototype.ON_GAME_DATA_REQUEST_SUCCESS = "ON_GAME_DATA_REQUEST_SUCCESS"
    prototype.ON_GAME_DATA_REQUEST_FAIL = "ON_GAME_DATA_REQUEST_FAIL"

    prototype.GAME_DATA_PARSED = "GAME_DATA_PARSED"

    m._eventTypeSingleton = prototype
  end if

  return m._eventTypeSingleton
end function

function DestroyEventType () as Void
  m._eventTypeSingleton = Invalid
end function
