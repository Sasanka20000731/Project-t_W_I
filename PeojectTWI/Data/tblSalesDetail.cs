//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace PeojectTWI.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class tblSalesDetail
    {
        public int InvoiceID { get; set; }
        public Nullable<int> InventoryId { get; set; }
        public Nullable<int> CoustomerId { get; set; }
        public Nullable<decimal> Discount { get; set; }
        public Nullable<decimal> SoldPrice { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public Nullable<decimal> ExtendPrice { get; set; }
    
        public virtual tblCoustomerDetail tblCoustomerDetail { get; set; }
        public virtual tblInventoryData tblInventoryData { get; set; }
    }
}
