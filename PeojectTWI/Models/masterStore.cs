using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PeojectTWI.Models
{
    public class masterStore
    {
        public int mStoreId { get; set; }
        public Nullable<int> ProductId { get; set; }
        public Nullable<int> perchesedCount { get; set; }
        public Nullable<decimal> unitPrice { get; set; }
        public Nullable<System.DateTime> PerchesedDate { get; set; }
        public Nullable<int> RecoredEnterdBy { get; set; }
        public Nullable<System.DateTime> createdDate { get; set; }
    }
}