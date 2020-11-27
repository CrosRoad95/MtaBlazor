let bridge = undefined
window.initializeBridge = (dotNetBridge) => {
    window.bridge = dotNetBridge;
    bridge = dotNetBridge
}

window.bridgeSetValue = (key, value) => {
    window.bridge.invokeMethodAsync("SetValue", key, value);
}