using PeojectTWI.Data;
using PeojectTWI.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace PeojectTWI.Services.TicketService
{
    public class TicketService :ITicketService
    {
        ProjectDBEntities db = new ProjectDBEntities();
        public List<Ticket> GetTicketDetailsToassign(int ticketId)
        {
            var result = (from a in db.tblTickets
                            where a.TicketId == ticketId
                          select new Ticket
                          {
                              TicketId = a.TicketId,
                              TicketDiscription = a.TicketDiscription,
                              CreatedDate = a.CreatedDate,
                              Coustomername = a.tblCoustomerDetail.CoustomerName,
                              CoustomerContact = a.tblCoustomerDetail.ContactNumber,
                              CoustomerEmail = a.tblCoustomerDetail.Email
                          }).ToList();

            return result;
        }


        public List<user> GetTicketHandlers()
        {
            var result = (from a in db.tblUsers
                          where a.AssignedTicketSequnceGroup == 2
                          select new user
                          {
                              UserId = a.UserId,
                              UserName = a.FirstName+" "+a.LastName 
                          }).ToList();

            return result;
        }



    }
}