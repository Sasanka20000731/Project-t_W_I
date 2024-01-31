using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PeojectTWI.Models
{
    public class Warrenty
    {
        public string SerialNo { get; set; }
        public string WarrentyStartDate { get; set; }

        public string WarrentyExpiredDate { get; set; }

        public string WarrentyComments { get; set; }
        public string WarrentyCommentedDate { get; set; }

        public string WarrentyStatus { get; set; }

        public Nullable<decimal> SoldPrice { get; set; }
    }
        

}