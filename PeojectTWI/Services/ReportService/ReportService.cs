using PeojectTWI.Data;
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
                var UserManagementReportDT = new DataTable();
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
                var UserManagementReportDS = new DataSet();
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
                        COL4 = row["COL4"].ToString(),
                        COL5 = row["COL5"].ToString()
                    };
                    reports.Add(report);
                }
            }
            return reports;
        }

    }
}