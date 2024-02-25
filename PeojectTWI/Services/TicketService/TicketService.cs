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

        //public List<object> LoadTicketdetailsToManage(int TicketID)
        //{
        //    var TicketDetals = (from a in db.tblTickets
        //                  where a.TicketId == TicketID
        //                  select new Ticket
        //                  {
        //                      TicketId = a.TicketId,
        //                      TicketDiscription = a.TicketDiscription,
        //                      TicketDate = a.CreatedDate.ToString(),
        //                      Coustomername = a.tblCoustomerDetail.CoustomerName,
        //                      CoustomerContact = a.tblCoustomerDetail.ContactNumber,
        //                      CoustomerEmail = a.tblCoustomerDetail.Email
        //                  }).ToList();

        //    var TicketComments = (from a in db.tblTicketComments
        //                          join b in db.tblUsers on a.CommentedBy equals b.UserId
        //                          where a.TicketID == TicketID
        //                          select new ticketComment
        //                          {
        //                              CommentedDate = a.CommentedDate.ToString(),
        //                              Comment = a.Comment,
        //                              CommentedBy = b.UserName
        //                          }).ToList();

        //    var ticketSequencelist = (from a in db.tblMasterTicketSequnces
        //                                 select new SequenceList
        //                                 {
        //                                     SequenceIndexId = a.SequanceIndexID,
        //                                     SequenceName = a.SequnceName
        //                                 }).ToList();


        //    var result = new List<object>();
        //    result.AddRange(TicketDetals);
        //    result.AddRange(TicketComments);
        //    result.AddRange(ticketSequencelist);

        //    return result;
        //}

        public List<Ticket> LoadTicketdetailsToManage(int TicketID)
        {
            List<Ticket> TicketDetails = new List<Ticket>();

            using (var context = new ProjectDBEntities())
            {
                var dataTable = new DataTable();
                using (var cmd = context.Database.Connection.CreateCommand())
                {
                    cmd.CommandText = "sp_LoadTicketdetailsToManage";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@@TicketID", TicketID));

                    using (var adapter = new SqlDataAdapter((SqlCommand)cmd))
                    {
                        adapter.Fill(dataTable);
                    }
                }

                var dataset = new DataSet();
                dataset.Tables.Add(dataTable);

                foreach (DataRow row in dataTable.Rows)
                {
                    Ticket ticket = new Ticket();


                    if (row["TicketId"] != DBNull.Value && row["TicketDescription"] != DBNull.Value && row["TicketDate"] != DBNull.Value)
                    {
                        ticket.TicketId = Convert.ToInt32(row["TicketId"]);
                        ticket.TicketDiscription = row["TicketDescription"].ToString();
                        ticket.TicketDate = row["TicketDate"].ToString();
                        ticket.CurrentSequnceIndex = Convert.ToInt32(row["CurrentSequnceIndex"]);
                        ticket.CurrentSequnce = row["CurrentSequnce"].ToString();
                        ticket.AssignDate = Convert.ToDateTime(row["AssignDate"]);
                        ticket.AssignedFrom = row["AssignFrom"].ToString();
                        ticket.CurrentStatus = Convert.ToString(row["TicketStatus"]);
                        ticket.SerialNumber = row["SerialNumber"].ToString();
                        ticket.TicketStatus = row["TicketStatus"].ToString();
                    }


                    // Ticket Comments
                    if (row["CommentedDate"] != DBNull.Value && row["Comment"] != DBNull.Value && row["CommentedBy"] != DBNull.Value)
                    {
                        ticket.TicketComment = new ticketComment
                        {
                            CommentedDate = row["CommentedDate"].ToString(),
                            Comment = row["Comment"].ToString(),
                            CommentedBy = row["CommentedBy"].ToString()
                        };
                    }

                    // SequnceIndex
                    if (row["SequnceIDList"] != DBNull.Value && row["SequnceNameList"] != DBNull.Value)
                    {
                        ticket.SequenceLists = new SequenceList
                        {
                            SequenceIndexId = Convert.ToInt32(row["SequnceIDList"]),
                            SequenceName = row["SequnceNameList"].ToString()
                        };
                    }

                    //Next Level User List
                    if (row["NextLevelUserId"] != DBNull.Value && row["NextLevelUserName"] != DBNull.Value)
                    {
                        ticket.nextUserList = new NextUserList
                        {
                            NextLevelUserId = Convert.ToInt32(row["NextLevelUserId"]),
                            NextLevelUserName = row["NextLevelUserName"].ToString()
                        };
                    }



                    TicketDetails.Add(ticket);
                }
            }
            return TicketDetails;


        }


        public int ManageTicketLevelToLevel(int TicketId, int StatusID, int? AssignTo) 
        {
            using (var context = new ProjectDBEntities())
            {
                using (var cmd = context.Database.Connection.CreateCommand())
                {
                    cmd.CommandText = "sp_ManageTicketLevelToLevel";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@@TicketID", TicketId));
                    cmd.Parameters.Add(new SqlParameter("@@StatusID", StatusID));
                    cmd.Parameters.Add(new SqlParameter("@@AssignedTo", AssignTo));
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

        public List<Ticket> SerchTickeList(int? TicketId,string customerContact = null)
        {
            var resultA = (from a in db.tblTickets
                          where a.TicketId == TicketId
                          select new Ticket
                          {
                              TicketId = a.TicketId,
                              TicketDate = a.CreatedDate.ToString(),
                              Coustomername = a.tblCoustomerDetail.CoustomerName,
                              CoustomerContact = a.tblCoustomerDetail.ContactNumber,
                              CoustomerEmail = a.tblCoustomerDetail.Email
                          }).ToList();


            var resultB = (from a in db.tblTickets
                          where a.tblCoustomerDetail.ContactNumber == customerContact
                          select new Ticket
                          {
                              TicketId = a.TicketId,
                              TicketDate = a.CreatedDate.ToString(),
                              Coustomername = a.tblCoustomerDetail.CoustomerName,
                              CoustomerContact = a.tblCoustomerDetail.ContactNumber,
                              CoustomerEmail = a.tblCoustomerDetail.Email
                          }).ToList();

            var combinedResult = resultA.Concat(resultB).ToList();

            return combinedResult;

        }
    }
}