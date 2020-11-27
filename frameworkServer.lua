function setValue(player, key, value)
	triggerClientEvent(player, "setPlayerBlazorValue", player, key, value)
end

addEvent("blazorCallFunction", true)
addEventHandler("blazorCallFunction", resourceRoot, function(func, data)
	iprint("call", func, data)
	call(getResourceFromName("MtaBlazorHelper"), func, client, data)
end)