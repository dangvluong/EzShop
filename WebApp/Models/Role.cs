﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApp.Models
{
    public class Role
    {
        public byte RoleId { get; set; }
        public string RoleName { get; set; }
        public bool Checked { get; set; }
    }
}
