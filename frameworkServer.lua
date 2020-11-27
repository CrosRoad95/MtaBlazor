function setValue(player, key, value)
	triggerClientEvent(player, "setPlayerBlazorValue", player, key, value)
end

function navigate(player, url)
	triggerClientEvent(player, "blazorNavigate", player, url)
end

addEvent("blazorCallFunction", true)
addEventHandler("blazorCallFunction", resourceRoot, function(func, ...)
	call(getResourceFromName("MtaBlazorHelper"), func, client, ...)
end)