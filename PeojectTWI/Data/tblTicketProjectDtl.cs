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
    
    public partial class tblTicketProjectDtl
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tblTicketProjectDtl()
        {
            this.tblTicketTaskAssigns = new HashSet<tblTicketTaskAssign>();
        }
    
        public int TicketProjectId { get; set; }
        public Nullable<int> TicketId { get; set; }
        public Nullable<int> CurrentSeqence { get; set; }
        public Nullable<int> Active { get; set; }
        public Nullable<System.DateTime> CreateDate { get; set; }
    
        public virtual tblTicket tblTicket { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tblTicketTaskAssign> tblTicketTaskAssigns { get; set; }
    }
}