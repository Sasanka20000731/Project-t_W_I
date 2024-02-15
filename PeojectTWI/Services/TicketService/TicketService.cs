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

        //public List<PipelineReport> GetPipelineSelectedMonthReport(string branchId, int? regionId, int? unit, int? selectedDay, int? selectedMonth, int? selectedYear)
        //{

        //    List<PipelineReport> pipelineReports = new List<PipelineReport>();
        //    using (var context = new FileRecoveryEntities())
        //    {
        //        var dataTable = new DataTable();
        //        using (var cmd = context.Database.Connection.CreateCommand())
        //        {
        //            cmd.CommandText = "Pipeline_Select_Detail_From_History";
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            cmd.Parameters.Add(new SqlParameter("@BranchId", branchId));
        //            cmd.Parameters.Add(new SqlParameter("@RegionId", regionId));
        //            cmd.Parameters.Add(new SqlParameter("@Unit", unit));
        //            cmd.Parameters.Add(new SqlParameter("@Day", selectedDay));
        //            cmd.Parameters.Add(new SqlParameter("@Month", selectedMonth));
        //            cmd.Parameters.Add(new SqlParameter("@Year", selectedYear));

        //            using (var adapter = new SqlDataAdapter((SqlCommand)cmd))
        //            {
        //                adapter.Fill(dataTable);
        //            }
        //        }
        //        var dataset = new DataSet();
        //        dataset.Tables.Add(dataTable);

        //        foreach (DataRow row in dataTable.Rows)
        //        {
        //            PipelineReport report = new PipelineReport
        //            {
        //                Branch = row["Branch"].ToString(),
        //                Region = row["Region"].ToString(),
        //                InitialTarget = Convert.ToDecimal(row["InitialTarget"]),
        //                GrantingAmount = Convert.ToDecimal(row["GrantingAmount"]),
        //                Pipeline = Convert.ToDecimal(row["Pipeline"]),
        //                IsUnit = Convert.ToBoolean(row["IsUnit"]),
        //                MainBranchId = row["MainBranchId"] as int?,
        //                BranchId = Convert.ToInt32(row["BranchId"]),
        //                Production = row["Production"].ToString(),
        //                RegionId = Convert.ToInt32(row["RegionId"]),
        //                MasterId = row["MasterId"].ToString(),
        //                Unit = Convert.ToInt32(row["Unit"]),
        //                GrantingFileCount = Convert.ToInt32(row["GrantingFileCount"]),
        //                PipelineFileCount = Convert.ToInt32(row["PipelineFileCount"]),
        //                WeightedAverage = Convert.ToDecimal(row["WeightedAverage"])

        //                //,
        //                //InterestRate =  Convert.ToInt32(row["InterestRate"])
        //            };
        //            pipelineReports.Add(report);
        //        }
        //    }
        //    return pipelineReports;
        //}

        //public DataSet DownloadReport(string branchId, int? regionId, int? unit, int? selectedDay, int? selectedMonth, int? selectedYear)
        //{
        //    using (var context = new FileRecoveryEntities())
        //    {
        //        var PipelineReportDataset = new DataTable();
        //        using (var cmd = context.Database.Connection.CreateCommand())
        //        {
        //            cmd.CommandText = "Pipeline_Select_Detail_From_History";
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            cmd.Parameters.Add(new SqlParameter("@BranchId", branchId));
        //            cmd.Parameters.Add(new SqlParameter("@RegionId", regionId));
        //            cmd.Parameters.Add(new SqlParameter("@Unit", unit));
        //            cmd.Parameters.Add(new SqlParameter("@Day", selectedDay));
        //            cmd.Parameters.Add(new SqlParameter("@Month", selectedMonth));
        //            cmd.Parameters.Add(new SqlParameter("@Year", selectedYear));
        //            using (var adapter = new SqlDataAdapter((SqlCommand)cmd))
        //            {
        //                adapter.Fill(PipelineReportDataset);
        //            }
        //        }
        //        var PipelineReportDatas = new DataSet();
        //        PipelineReportDatas.Tables.Add(PipelineReportDataset);
        //        return PipelineReportDatas;
        //    }
        //}

        public List<Ticket> LogadPendingTickets(int LoggedUser)
        {
            List<Ticket> PendingTickets = new List<Ticket>();

            using (var context = new ProjectDBEntities())
            {
                var dataTable = new DataTable();
                using (var cmd = context.Database.Connection.CreateCommand())
                {
                    cmd.CommandText = "sp_LogadPendingTickets";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@@UserID", LoggedUser));
 
                    using (var adapter = new SqlDataAdapter((SqlCommand)cmd))
                    {
                        adapter.Fill(dataTable);
                    }
                }

                var dataset = new DataSet();
                dataset.Tables.Add(dataTable);

                foreach (DataRow row in dataTable.Rows)
                {
                    Ticket ticket = new Ticket
                    {
                        TicketId = Convert.ToInt32(row["TicketID"]),
                        TicketDiscription = row["TicketDescription"].ToString(),
                        AssignDate = Convert.ToDateTime(row["AssignDate"]),
                        CurrentStatus = Convert.ToString(row["CurrentStatus"])
                    };
                    PendingTickets.Add(ticket);
                }
            }
            return PendingTickets;
        }
    }
}