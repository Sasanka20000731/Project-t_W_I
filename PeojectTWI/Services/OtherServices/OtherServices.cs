using PeojectTWI.Data;
using PeojectTWI.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace PeojectTWI.Services.OtherServices
{
    public class OtherServices : IOtherServices
    {
        ProjectDBEntities db = new ProjectDBEntities();

        public void InsertAuditTrial(int AuditTrialType, string Description, int CreatedBy)
        {
            //-----------------un comment this function
            using (var context = new ProjectDBEntities())
            {
                using (var cmd = context.Database.Connection.CreateCommand())
                {
                    cmd.CommandText = "sp_AuditTrial";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@@AuditTrialType", AuditTrialType));
                    cmd.Parameters.Add(new SqlParameter("@@Description", Description));
                    cmd.Parameters.Add(new SqlParameter("@@CreatedBy", CreatedBy));
                    context.Database.Connection.Open();
                    var result = cmd.ExecuteScalar();
                }
            }
        }

        public List<Dashbord> LoadDashbord(int UserId)
        {
            List<Dashbord> dashbords = new List<Dashbord>();

            using (var context = new ProjectDBEntities())
            {
                var dataTable = new DataTable();
                using (var cmd = context.Database.Connection.CreateCommand())
                {
                    cmd.CommandText = "sp_GetDashbordDetails";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@@UserId", UserId));

                    using (var adapter = new SqlDataAdapter((SqlCommand)cmd))
                    {
                        adapter.Fill(dataTable);
                    }
                }

                var dataset = new DataSet();
                dataset.Tables.Add(dataTable);

                foreach (DataRow row in dataTable.Rows)
                {
                    Dashbord dashbord = new Dashbord
                    {
                        PendingTickets = Convert.ToInt32(row["PendingTickets"]),
                        OpenedTickets = Convert.ToInt32(row["OpenedTickets"]),
                        ClosedTickets = Convert.ToInt32(row["ClosedTickets"])
                    };
                    dashbords.Add(dashbord);
                }
            }
            return dashbords;

        }


        //public List<Dashbord> LoadDashbordChart()
        //{
        //    List<Dashbord> dashbords = new List<Dashbord>();


        //    Dashbord dashbord1 = new Dashbord();
        //    dashbord1.TicketCount = 15;
        //    dashbord1.TicketDate = "2024, 1, 1";
        //    dashbords.Add(dashbord1);

        //    Dashbord dashbord2 = new Dashbord();
        //    dashbord2.TicketCount = 24;
        //    dashbord2.TicketDate = "2024, 4, 1";
        //    dashbords.Add(dashbord2);


        //    Dashbord dashbord3 = new Dashbord();
        //    dashbord3.TicketCount = 24;
        //    dashbord3.TicketDate = "2024, 4, 1";
        //    dashbords.Add(dashbord3);


        //    return dashbords;
        //}

        public List<Dashbord> LoadDashbordChart()
        {
            List<Dashbord> dashbords = new List<Dashbord>();

            var rawTickets = (from a in db.tblTickets
                              select new
                              {
                                  a.TicketId,
                                  a.CreatedDate
                              }).ToList();

           
            var ticketList = rawTickets.Select(a => new Ticket
            {
                TicketId = a.TicketId,
                TicketDate = a.CreatedDate.HasValue
                             ? a.CreatedDate.Value.ToString("yyyy-MM-dd")
                             : null
            }).ToList();

            var groupedTickets = ticketList
                                .GroupBy(t => t.TicketDate)
                                .Select(g => new
                                {
                                    TicketDate = g.Key,
                                    TicketCount = g.Count()
                                }).ToList();


            foreach (var item in groupedTickets)
            {
                Dashbord dashbord = new Dashbord
                {
                    TicketCount = item.TicketCount,
                    TicketDate = item.TicketDate
                };
                dashbords.Add(dashbord);
            }

            return dashbords;


        }



    }
}