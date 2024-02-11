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
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public Nullable<bool> IsOpen { get; set; }
        public Nullable<bool> IsClosed { get; set; }
        public Nullable<System.DateTime> OpenedDate { get; set; }
        public Nullable<System.DateTime> ClosedDate { get; set; }
    }
}