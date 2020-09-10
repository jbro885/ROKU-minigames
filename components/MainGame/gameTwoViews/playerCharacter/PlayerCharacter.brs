function init()
    m.top.observeField("direction", "changeDirection")
    m.top.observeField("size", "createPlayerCharacter")
    m.player = m.top.findNode("playerTexture")
end function

function createPlayerCharacter()
    context = m.top
    m.player.uri = "pkg:/images/characterDown.png"
    m.player.width = context.size
    m.player.height = context.size
end function

function changeDirection()
    if (m.top.direction = "up")
        m.player.uri = "pkg:/images/characterUp.png"
    else if (m.top.direction = "down")
        m.player.uri = "pkg:/images/characterDown.png"
    else if (m.top.direction = "left")
        m.player.uri = "pkg:/images/characterLeft.png"
    else if (m.top.direction = "right")
        m.player.uri = "pkg:/images/characterRight.png"
    end if
end function