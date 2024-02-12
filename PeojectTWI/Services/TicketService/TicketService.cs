﻿using PeojectTWI.Data;
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

        public int AddTicket(string SerialNumber, string TicketRemark, int User)
        {
            using (var context = new ProjectDBEntities())
            {
                using (var cmd = context.Database.Connection.CreateCommand())
                {
                    cmd.CommandText = "sp_AddTicket";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@@SerialNumber", SerialNumber));
                    cmd.Parameters.Add(new SqlParameter("@@TicketRemark", TicketRemark));
                    context.Database.Connection.Open();
                    var result = cmd.ExecuteScalar();
                    if (result != null && int.TryParse(result.ToString(), out int spResult))
                    {
                        return spResult;
                    }
                    else
                    {
                        return 0;
                    }
                }
            }
        }

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

        public int AssignTicketToHandler(int ticketID, int assignToUsrer, int LoggedUserID)
        {
            using (var context = new ProjectDBEntities())
            {
                using (var cmd = context.Database.Connection.CreateCommand())
                {
                    cmd.CommandText = "sp_AssignTicket";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@@TicketID", ticketID));
                    cmd.Parameters.Add(new SqlParameter("@@AssignedTo", assignToUsrer));
                    cmd.Parameters.Add(new SqlParameter("@@UserID", LoggedUserID));
                    context.Database.Connection.Open();
                    var result = cmd.ExecuteScalar();
                    if (result != null && int.TryParse(result.ToString(), out int spResult))
                    {
                        return spResult;
                    }
                    else
                    {
                        return 0;
                    }
                }
            }
        }

    }
}