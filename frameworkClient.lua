local screenWidth, screenHeight = 800,800
local browserReady = false;

addEvent("onBlazorBrowserReady")
local window = guiCreateWindow( 200, 50, screenWidth, screenHeight, "Mta Blazor", false )
local browser = guiCreateBrowser( 0, 28, screenWidth, screenHeight, true, false, false, window )
local blazorBrowser = guiGetBrowser( browser )

addEventHandler( "onClientBrowserCreated", blazorBrowser, 
	function( )
		loadBrowserURL( source, "http://mta/local/index.html" )
		toggleBrowserDevTools(source, true)
		browserReady = true
		triggerEvent("onBlazorBrowserReady", root, source)
		setTimer(function()
			setValue("test",math.random(1000))
		end,500,0)
	end
)

local _fromJSON = fromJSON
local _toJSON = toJSON

function fromJSON(text)
    return _fromJSON("["..text.."]")
end

function toJSON(object)
    local str = _toJSON(object, true);
    return string.sub(str, 2, string.len(str) - 1)
end

function callBridgeFunction(func,...)
	local args = {...}
	local t = {}
	for i=1,#args do
		t[#t + 1] = "%q"
	end
	local code = string.format("window.bridge.invokeMethodAsync(%q,"..table.concat(t, ",")..")", func, ...)
	executeBrowserJavascript(blazorBrowser, code)
end

function setValue(key, value)
	if(not browserReady)then return false end
	local value = base64Encode(toJSON(value))
	callBridgeFunction("SetValue", key, value)
end

setDevelopmentMode(true, true)