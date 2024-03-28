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

        public List<CommonReport> SearchUserManagementReport(DateTime FromDate, DateTime ToDate, int ReportCategory, int ReportType)
        {
            throw new NotImplementedException();
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