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
    
    public partial class tblProductCategory
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tblProductCategory()
        {
            this.tblMasterStores = new HashSet<tblMasterStore>();
        }
    
        public int ProductID { get; set; }
        public string BrandName { get; set; }
        public string VendorName { get; set; }
        public string VendorContact { get; set; }
        public string VendorAddress { get; set; }
        public string VendorEmail { get; set; }
        public Nullable<System.DateTime> CreateDate { get; set; }
        public Nullable<bool> Active { get; set; }
        public string ProductName { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tblMasterStore> tblMasterStores { get; set; }
    }
}
