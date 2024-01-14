using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PeojectTWI.Models
{
    public class saleItem
    {
        public string  SerialNumber { get; set; }
        public Nullable<decimal> unitPrice { get; set; }
        public string BrandName { get; set; }
        public string ProductName  { get; set; }
        public string vendorName { get; set; }

    }
}