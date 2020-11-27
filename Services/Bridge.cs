using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MtaBlazor.Services
{
    public class Bridge
    {
        private readonly IJSRuntime jSRuntime;
        public event Action<string, string> OnValueChange;
        private bool bridgeReady = false;

        public Bridge(IJSRuntime jSRuntime)
        {
            this.jSRuntime = jSRuntime;
        }
        public async Task InitializeAsync()
        {
            await jSRuntime.InvokeVoidAsync("initializeBridge", DotNetObjectReference.Create(this));
            bridgeReady = true;
        }

        [JSInvokable]
        public bool SetValue(string key, System.Text.Json.JsonElement value)
        {
            if (String.IsNullOrWhiteSpace(key))
                return false;

            string base64 = null;
            try
            {
                base64 = value.GetString();
            }
            catch(Exception ex)
            {
                return false;
            }
            string json = System.Text.Encoding.UTF8.GetString(Convert.FromBase64String(base64));
            OnValueChange?.Invoke(key, json);
            return true;
        }

        public void Call(params object[] vs)
        {
            jSRuntime.InvokeVoidAsync("callFunction", vs);
        }

        public void CallServer(params object[] vs)
        {
            jSRuntime.InvokeVoidAsync("callServerFunction", vs);
        }
    }
}
