function init()
    m.top.observeField("content", "onContentUpdate")
    m.top.observeField("onFocus", "onFocus")
    m.top.observeField("newColor", "onNewColor")
    m.rectangle = m.top.createChild("Rectangle")
    m.FOCUS_COLOR = "#ff0000"
end function    

function onContentUpdate()
    m.content = m.top.content
    m.rectangle.width = m.content.width
    m.rectangle.height = m.content.height
    m.rectangle.color = m.content.color
end function    

function onNewColor()
    m.rectangle.color = m.top.newColor
    m.content.color = m.top.newColor
end function    

function onFocus()
    if (m.top.onFocus = true)
        m.rectangle.color = m.FOCUS_COLOR
    else
        m.rectangle.color = m.content.color
    end if        
    
end function 