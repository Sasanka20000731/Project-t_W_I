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
    
    public partial class tblTicketStatu
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tblTicketStatu()
        {
            this.tblTicketTaskAssigns = new HashSet<tblTicketTaskAssign>();
        }
    
        public int TicketStatusId { get; set; }
        public string TicketStatus { get; set; }
    
        public virtual tblTicketStatu tblTicketStatus1 { get; set; }
        public virtual tblTicketStatu tblTicketStatu1 { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tblTicketTaskAssign> tblTicketTaskAssigns { get; set; }
    }
}