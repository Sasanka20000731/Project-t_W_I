using PeojectTWI.Data;
using PeojectTWI.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PeojectTWI.Services.ReportService
{
    interface IReportService
    {

        List<ReportList> LoadUserManagementReportData(int ReportCategory);

        List<CommonReport> SearchUserManagementReport(DateTime FromDate, DateTime ToDate, int ReportCategory, int ReportType);

        List<CommonReport> InventoryManagementReport(DateTime FromDate, DateTime ToDate, int ReportCategory, int ReportType);

    }
}