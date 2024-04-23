using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PeojectTWI.Models
{
    public class Dashbord
    {
        public int PendingTickets { get; set; }
        public int OpenedTickets { get; set; }
        public int ClosedTickets { get; set; }

        public string CurrentDate { get; set; }

        // Constructor to initialize the CurrentDate property with the current date
        public Dashbord()
        {
            CurrentDate = DateTime.Now.ToShortDateString();

        }

        public int TicketCount { get; set; }

        public DateTime TicketDate { get; set; }


    }
}