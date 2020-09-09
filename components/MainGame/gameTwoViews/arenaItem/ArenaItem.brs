function init()
    m.top.observeField("content", "onContentUpdate")
    m.itemPoster = m.top.createChild("Poster")
end function    

function onContentUpdate()
    content = m.top.content
    if (content.itemType = "wall")
        m.itemPoster.uri = "pkg:/images/grassTile.jpg"
    else if (content.itemType = "way") 
        m.itemPoster.uri = "pkg:/images/asphalt.jpg"  
    end if
    m.itemPoster.width = content.width
    m.itemPoster.height = content.height
end function    