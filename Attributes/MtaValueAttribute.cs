﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MtaBlazor.Attributes
{
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    public class MtaValueAttribute : Attribute
    {
        public string Name { get; private set; }
        public MtaValueAttribute(string name)
        {
            Name = name;
        }
    }
}
