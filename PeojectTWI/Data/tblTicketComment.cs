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
    
    public partial class tblTicketComment
    {
        public int ticketCommentID { get; set; }
        public Nullable<int> mTicketID { get; set; }
        public string Comment { get; set; }
        public Nullable<System.DateTime> CommentedDate { get; set; }
        public Nullable<int> CommentedBy { get; set; }
    
        public virtual tblMasterTicketDetail tblMasterTicketDetail { get; set; }
    }
}
