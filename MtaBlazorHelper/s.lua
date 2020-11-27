function getServerTick(player, data)
    exports.blazor:setValue(player, "serverTick", getTickCount());
end