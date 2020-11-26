local screenWidth, screenHeight = 600,600

local window = guiCreateWindow( 200, 50, screenWidth, screenHeight, "Mta Blazor", false )
local browser = guiCreateBrowser( 0, 28, screenWidth, screenHeight, true, false, false, window )
local theBrowser = guiGetBrowser( browser )

addEventHandler( "onClientBrowserCreated", theBrowser, 
	function( )
		loadBrowserURL( source, "http://mta/local/index.html" )
		toggleBrowserDevTools(source, true)
	end
)

setDevelopmentMode(true, true)