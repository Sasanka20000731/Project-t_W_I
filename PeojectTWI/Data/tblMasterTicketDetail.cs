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
    
    public partial class tblMasterTicketDetail
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tblMasterTicketDetail()
        {
            this.tblTicketComments = new HashSet<tblTicketComment>();
        }
    
        public int mTicketID { get; set; }
        public Nullable<int> TicketID { get; set; }
        public Nullable<bool> isAssigned { get; set; }
        public Nullable<System.DateTime> AssignedDate { get; set; }
        public Nullable<int> AssignedTo { get; set; }
        public Nullable<bool> IsAccepted { get; set; }
    
        public virtual tblTicket tblTicket { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tblTicketComment> tblTicketComments { get; set; }
    }
}
