let bridge = undefined
let callFunction = undefined
let callServerFunction = undefined

window.initializeBridge = (dotNetBridge) => {
    window.bridge = dotNetBridge;
    bridge = dotNetBridge
    if (typeof mta !== "undefined") {
        console.log("Mta Blazor ready");
        mta.triggerEvent("onBlazorReady")
    }
}

window.bridgeSetValue = (key, value) => {
    window.bridge.invokeMethodAsync("SetValue", key, value);
}

if (typeof mta === "undefined") {
    callFunction = (func, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) => {
        const obj = [arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8]
        const json = JSON.stringify(obj)
        console.log("client call",func, json)
    }
    callServerFunction = (func, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) => {
        const obj = [arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8]
        const json = JSON.stringify(obj)
        console.log("server call",func, json)
    }
}
else {
    callFunction = (func, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) => {
        const obj = [arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8]
        const json = JSON.stringify(obj, (key, value) => {
            if (value !== null) return value
        })
        return mta.triggerEvent("onBlazorCall", func, json)
    }
    callServerFunction = (func, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) => {
        const obj = [arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8]
        const json = JSON.stringify(obj, (key, value) => {
            if (value !== null) return value
        })
        return mta.triggerEvent("onBlazorCallServer", func, json)
    }
}

window.callFunction = callFunction;
window.callServerFunction = callServerFunction;