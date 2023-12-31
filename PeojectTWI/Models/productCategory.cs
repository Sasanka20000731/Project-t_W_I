using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PeojectTWI.Models
{
    public class productCategory
    {
        public int ProductID { get; set; }
        public string BrandName { get; set; }
        public string VendorName { get; set; }
        public string VendorContact { get; set; }
        public string VendorAddress { get; set; }
        public string VendorEmail { get; set; }

        public bool Active { get; set; }
    }
}