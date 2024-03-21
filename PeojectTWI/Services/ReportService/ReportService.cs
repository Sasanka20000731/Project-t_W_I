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

        public List<ReportList> SearchUserManagementReport(DateTime FromDate, DateTime ToDate, int ReportCategory, int ReportType)
        {
            throw new NotImplementedException();
        }
    }
}