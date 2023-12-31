using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PeojectTWI.Models
{
    public class WHmanage
    {
        public string BrandName { get; set; }
        public string VendorName { get; set; }
        public string VendorContact { get; set; }
        public string VendorEmail { get; set; }
        public int PerchesedCount { get; set; }
        public decimal UnitPrice { get; set; }
        public decimal TotalCost { get; set; }
        public int InSaleInventory { get; set; }
        public int NotInAnyStore { get; set; }
        public int RemainingCount { get; set; }
    }
}