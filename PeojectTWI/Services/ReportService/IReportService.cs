using PeojectTWI.Data;
using PeojectTWI.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PeojectTWI.Services.ReportService
{
    interface IReportService
    {

        List<ReportList> LoadUserManagementReportData(int ReportCategory);

        List<user> SearchUserManagementReport(DateTime FromDate, DateTime ToDate, int ReportCategory, int ReportType);

        List<CommonReport> InventoryManagementReport(DateTime FromDate, DateTime ToDate, int ReportCategory, int ReportType);

        DataSet DownloadUserManagementReport(DateTime FromDate, DateTime ToDate, int ReportCategory, int ReportType);

    }
}