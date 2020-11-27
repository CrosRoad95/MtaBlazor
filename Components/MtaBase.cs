using Microsoft.AspNetCore.Components;
using MtaBlazor.Attributes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Reflection;
using MtaBlazor.Services;
using System.Text.Json;

namespace MtaBlazor.Components
{
    public class MtaBase : LayoutComponentBase
    {
        [Inject] public Bridge Bridge { get; set; }
        private readonly IEnumerable<PropertyInfo> properties;
        private readonly Dictionary<string, List<PropertyInfo>> propertiesByName = new Dictionary<string, List<PropertyInfo>>();

        public MtaBase()
        {
            properties = GetType().GetProperties().Where(prop => prop.IsDefined(typeof(MtaValueAttribute), false));
            foreach (var item in properties)
            {
                MtaValueAttribute value = item.GetCustomAttribute<MtaValueAttribute>();
                if(!propertiesByName.ContainsKey(value.Name))
                {
                    propertiesByName[value.Name] = new List<PropertyInfo>();
                }
                propertiesByName[value.Name].Add(item);
            }
        }

        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
            if (firstRender)
            {
                await Bridge.InitializeAsync();
                Bridge.OnValueChange += Bridge_OnValueChange;
            }
            base.OnAfterRender(firstRender);
        }

        private void Bridge_OnValueChange(string key, string value)
        {
            SetValue(key, value);
        }

        public void SetValue(string key, string json)
        {
            if (!propertiesByName.TryGetValue(key, out var properties))
                return;

            if (properties.Count() == 0)
                return;

            PropertyInfo firstProperty = properties.First();
            object? result = default;
            try
            {
                result = JsonSerializer.Deserialize(json, firstProperty.PropertyType);
            }
            catch(Exception _)
            {
                return;
            }

            foreach (var property in properties)
            {
                property.SetValue(this, result);
            }

            InvokeAsync(() =>
            {
                StateHasChanged();
            });
        }
    }
}
