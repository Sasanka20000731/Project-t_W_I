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
    
    public partial class tblInventoryHistory
    {
        public int inventoryHistoryId { get; set; }
        public Nullable<int> inventoryId { get; set; }
        public string Remark { get; set; }
        public Nullable<System.DateTime> createDate { get; set; }
        public Nullable<int> createdby { get; set; }
    
        public virtual tblInventoryData tblInventoryData { get; set; }
        public virtual tblUser tblUser { get; set; }
    }
}
