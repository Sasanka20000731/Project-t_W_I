using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PeojectTWI.Models
{
    public class Ticket
    {
        public int TicketId { get; set; }
        public Nullable<int> InventoryID { get; set; }
        public Nullable<int> CoustomerId { get; set; }
        public string Coustomername { get; set; }
        public string CoustomerContact { get; set; }
        public string CoustomerEmail { get; set; }
        public string TicketDiscription { get; set; }
        public string TicketStatus { get; set; }
        public string CurrentStatus { get; set; }
        public string SerialNumber { get; set; }
        public string AssignedFrom { get; set; }
        public int CurrentSequnceIndex { get; set; }
        public string CurrentSequnce { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; } 
        public string TicketDate { get; set; }
        public Nullable<bool> IsOpen { get; set; }
        public Nullable<bool> IsClosed { get; set; }
        public Nullable<System.DateTime> OpenedDate { get; set; }
        public Nullable<System.DateTime> ClosedDate { get; set; }
        public Nullable<System.DateTime> AssignDate { get; set; }

        public ticketComment TicketComment { get; set; }
        public SequenceList SequenceLists { get; set; }
        public NextUserList nextUserList { get; set; }
    }

    public class ticketComment
    {
        public int CommentID { get; set; }
        public string CommentedDate { get; set; }
        public string Comment { get; set; }
        public string CommentedBy { get; set; }
    }

    public class SequenceList
    {
        public int SequenceIndexId { get; set; }
        public string SequenceName { get; set; }
    }

    public class NextUserList
    {
        public int NextLevelUserId { get; set; }
        public string NextLevelUserName { get; set; }
    }



}