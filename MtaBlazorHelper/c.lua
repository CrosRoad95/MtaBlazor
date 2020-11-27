_outputChatBox = outputChatBox;
function outputChatBox(message)
    _outputChatBox(message)
end

addEventHandler("onBlazorReady", root, function()
	outputChatBox("Blazor ready")
	setTimer(function()
		exports.blazor:setValue("clientTick",getTickCount())
	end,500,0)
end)