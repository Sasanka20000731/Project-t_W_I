using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PeojectTWI.Models
{
    public class SerialItem
    {
        public string BrandName { get; set; }
        public string ProductName { get; set; }
        public string VendorName { get; set; }
        public string VendorEmail { get; set; }
        public string VendorContact { get; set; }

        public string CurrentLocation { get; set; }

        public string InOrOutDateStr { get; set; }


    }
}