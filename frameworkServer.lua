function setValue(player, key, value)
	triggerClientEvent(player, "setPlayerBlazorValue", player, key, value)
end

addEvent("blazorCallFunction", true)
addEventHandler("blazorCallFunction", resourceRoot, function(func, ...)
	call(getResourceFromName("MtaBlazorHelper"), func, client, ...)
end)