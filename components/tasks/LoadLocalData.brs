sub init()
  m.top.functionname = "load"
end sub

function load()
    if m.top.filepath = ""
        m.top.error = "Data can't be loaded because filepath not provided."
    else
	    data=ReadAsciiFile(m.top.filepath)
	    if data = invalid
	        m.top.error = "File contents invalid."
	    else
	        m.top.filedata = data
	    end if
	end if
end function