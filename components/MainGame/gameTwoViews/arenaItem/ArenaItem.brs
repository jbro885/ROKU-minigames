function init()
    m.top.observeField("content", "onContentUpdate")
    m.top.observeField("weight", "onWeightUpdate")
    m.top.observeField("isShortestPathItem", "onShortPathShow")
    m.itemPoster = m.top.createChild("Poster")
    m.itemPosterLabel = m.itemPoster.createChild("Label")
end function    

function onContentUpdate()
    content = m.top.content
    if (content.itemType = "wall")
        m.itemPoster.uri = "pkg:/images/grassTile.jpg"
    else if (content.itemType = "way") 
    end if
    m.itemPoster.width = content.width
    m.itemPoster.height = content.height
end function   

function onShortPathShow()
    m.itemPoster.uri = "pkg:/images/asphalt.jpg"  
end function    

function onWeightUpdate()
    m.itemPosterLabel.text = m.top.weight
    m.itemPoster.opacity = 1
    m.itemPosterLabel.color = "#000000"
end function    