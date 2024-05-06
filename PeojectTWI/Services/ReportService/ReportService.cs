﻿using PeojectTWI.Data;
using PeojectTWI.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace PeojectTWI.Services.ReportService
{
    public class ReportService : IReportService
    {
        ProjectDBEntities db = new ProjectDBEntities();

        public List<ReportList> LoadUserManagementReportData(int ReportCategory)
        {
            var result = (from a in db.tblReportCategories
                          join b in db.tblReportTypes on a.ReportCategoryId equals b.ReportCategoryId
                          where a.Active == true && b.Active == true && a.ReportCategoryId == ReportCategory
                          select new ReportList
                          {
                              Value = b.ReportTypeValue,
                              Name = b.ReportTypeName
                          }).ToList();

            return result;
        }
        public List<user> SearchUserManagementReport(DateTime FromDate, DateTime ToDate, int ReportCategory, int ReportType)
        {
            List<user> UserManageReportList = new List<user>();

            using (var context = new ProjectDBEntities())
            {
                var DataTable1 = new DataTable();

                using (var command = context.Database.Connection.CreateCommand())
                {
                    command.CommandText = "exec [sp_UserManageReport] @@FromDate,@@ToDate, @@ReportCategory,@@ReportType";
                    command.Parameters.Add(new SqlParameter("@@FromDate", (object)FromDate ?? DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@@ToDate", (object)ToDate ?? DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@@ReportCategory", (object)ReportCategory ?? DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@@ReportType", (object)ReportType ?? DBNull.Value));
                    context.Database.Connection.Open();

                    using (var reader = command.ExecuteReader())
                    {
                        DataTable1.Load(reader);
                    }
                }

                foreach (DataRow row in DataTable1.Rows)
                {
                    user UserManageReport = new user
                    {
                        FullName = row["FullName"].ToString(),
                        CreateDateString = row["CreateDate"].ToString(),
                        StatusString = row["Status"].ToString(),
                        UserLevelString = row["UserLevel"].ToString(),
                        Remark = row["Remark"].ToString()
                    };

                    UserManageReportList.Add(UserManageReport);
                }
            }

            return UserManageReportList.ToList();

        }
        public DataSet DownloadUserManagementReport(DateTime FromDate, DateTime ToDate, int ReportCategory, int ReportType)
        {
            using (var context = new ProjectDBEntities())
            {
                var UserManagementReportDT = new DataTable("UserManagementDataTable"); 
                using (var command = context.Database.Connection.CreateCommand())
                {
                    command.CommandText = "exec [sp_UserManageReport] @@FromDate,@@ToDate, @@ReportCategory,@@ReportType";
                    command.Parameters.Add(new SqlParameter("@@FromDate", (object)FromDate ?? DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@@ToDate", (object)ToDate ?? DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@@ReportCategory", (object)ReportCategory ?? DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@@ReportType", (object)ReportType ?? DBNull.Value));
                    using (var adapter = new SqlDataAdapter((SqlCommand)command))
                    {
                        adapter.Fill(UserManagementReportDT);
                    }
                }
                var UserManagementReportDS = new DataSet("UserManagemenrDataset");
                UserManagementReportDS.Tables.Add(UserManagementReportDT);
                return UserManagementReportDS;
            }
        }
        public List<CommonReport> InventoryManagementReport(DateTime FromDate, DateTime ToDate, int ReportCategory, int ReportType)
        {
            List<CommonReport> reports = new List<CommonReport>();

            using (var context = new ProjectDBEntities())
            {
                var DataTable1 = new DataTable();
                using (var command = context.Database.Connection.CreateCommand())
                {
                    command.CommandText = "EXEC sp_InventoryManagementReport @FromDate, @ToDate, @ReportCategory, @ReportType";
                    command.Parameters.Add(new SqlParameter("@FromDate", FromDate));
                    command.Parameters.Add(new SqlParameter("@ToDate", ToDate));
                    command.Parameters.Add(new SqlParameter("@ReportCategory", ReportCategory));
                    command.Parameters.Add(new SqlParameter("@ReportType", ReportType));

                    context.Database.Connection.Open();
                    using (var reader = command.ExecuteReader())
                    {
                        DataTable1.Load(reader);
                    }
                }
                foreach (DataRow row in DataTable1.Rows)
                {
                    CommonReport report = new CommonReport
                    {
                        COL1 = row["COL1"].ToString(),
                        COL2 = row["COL2"].ToString(),
                        COL3 = row["COL3"].ToString(),
                        COL4 = row["COL4"].ToString()
                    };
                    reports.Add(report);
                }
            }
            return reports;
        }
        
        public DataSet DownloadCommonManagementReport(DateTime FromDate, DateTime ToDate, int ReportCategory, int ReportType)
        {
            var DataSet = new DataSet("CommonDataSet");

            using (var context = new ProjectDBEntities())
            {
                var DataTable = new DataTable("CommonDataTable");
                using (var command = context.Database.Connection.CreateCommand())
                {
                    command.CommandText = "EXEC sp_InventoryManagementReport @FromDate, @ToDate, @ReportCategory, @ReportType";
                    command.Parameters.Add(new SqlParameter("@FromDate", FromDate));
                    command.Parameters.Add(new SqlParameter("@ToDate", ToDate));
                    command.Parameters.Add(new SqlParameter("@ReportCategory", ReportCategory));
                    command.Parameters.Add(new SqlParameter("@ReportType", ReportType));

                    context.Database.Connection.Open();
                    using (var reader = command.ExecuteReader())
                    {
                        DataTable.Load(reader);
                    }
                }


                    DataSet.Tables.Add(DataTable);
                
            }
            return DataSet;
        }





        public List<CommonReport> SearchTicketManagementReport(DateTime fromDate, DateTime toDate, int reportCategory, int reportType)
        {
            List<CommonReport> reports = new List<CommonReport>();

            using (var context = new ProjectDBEntities())
            {
                var DataTable1 = new DataTable();
                using (var command = context.Database.Connection.CreateCommand())
                {
                    command.CommandText = "EXEC sp_TicketManagementReport @FromDate, @ToDate, @ReportCategory, @ReportType";
                    command.Parameters.Add(new SqlParameter("@FromDate", fromDate));
                    command.Parameters.Add(new SqlParameter("@ToDate", toDate));
                    command.Parameters.Add(new SqlParameter("@ReportCategory", reportCategory));
                    command.Parameters.Add(new SqlParameter("@ReportType", reportType));

                    context.Database.Connection.Open();
                    using (var reader = command.ExecuteReader())
                    {
                        DataTable1.Load(reader);
                    }
                }
                foreach (DataRow row in DataTable1.Rows)
                {
                    CommonReport report = new CommonReport
                    {
                        COL1 = row["COL1"] == DBNull.Value ? string.Empty : row["COL1"].ToString(),
                        COL2 = row["COL2"] == DBNull.Value ? string.Empty : row["COL2"].ToString(),
                        COL3 = row["COL3"] == DBNull.Value ? string.Empty : row["COL3"].ToString(),
                        COL4 = row["COL4"] == DBNull.Value ? string.Empty : row["COL4"].ToString()
                    };
                    reports.Add(report);
                }
            }
            return reports;
        }
        public List<CommonReport> SearchWarrentyManagementReport(DateTime FromDate, DateTime ToDate, int ReportCategory, int ReportType)
        {
            List<CommonReport> reports = new List<CommonReport>();

            using (var context = new ProjectDBEntities())
            {
                var DataTable1 = new DataTable();
                using (var command = context.Database.Connection.CreateCommand())
                {
                    command.CommandText = "EXEC sp_WarrentyManagementReport @FromDate, @ToDate, @ReportCategory, @ReportType";
                    command.Parameters.Add(new SqlParameter("@FromDate", FromDate));
                    command.Parameters.Add(new SqlParameter("@ToDate", ToDate));
                    command.Parameters.Add(new SqlParameter("@ReportCategory", ReportCategory));
                    command.Parameters.Add(new SqlParameter("@ReportType", ReportType));

                    context.Database.Connection.Open();
                    using (var reader = command.ExecuteReader())
                    {
                        DataTable1.Load(reader);
                    }
                }
                foreach (DataRow row in DataTable1.Rows)
                {
                    CommonReport report = new CommonReport
                    {
                        COL1 = row["COL1"].ToString(),
                        COL2 = row["COL2"].ToString(),
                        COL3 = row["COL3"].ToString(),
                        COL4 = row["COL4"].ToString()
                    };
                    reports.Add(report);
                }
            }
            return reports;
        }
        public List<ReportList> LoadAuditTrialTypes()
        {
            var result = (from a in db.tblAuditTrialTypes
                          where a.Active == true
                          select new ReportList
                          {
                              Value = a.Id,
                              Name = a.AuditTrialType
                          }).ToList();


            return result;
        }
        public List<CommonReport> SearchAuditTrialReport(DateTime FromDate, DateTime ToDate, int ReportType)
        {
            DateTime todate = ToDate.AddHours(23).AddMinutes(59);

            var result = (from a in db.tblAuditTrials
                          join b in db.tblAuditTrialTypes on a.AuditTrialType equals b.Id
                          join c in db.tblUsers on a.CreatedBy equals c.UserId
                          where a.CreatedDate > FromDate && a.CreatedDate < todate && a.AuditTrialType == ReportType
                          select new CommonReport
                          {
                              COL1 = b.AuditTrialType,
                              COL2 =a.Description,
                              COL3 = c.FirstName +" "+c.LastName,
                              COL4 = a.CreatedDate.ToString()
                          }).ToList();


            return result;

        }



    }
}