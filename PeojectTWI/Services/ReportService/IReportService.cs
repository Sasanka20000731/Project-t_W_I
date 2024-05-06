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

        DataSet DownloadCommonManagementReport(DateTime FromDate, DateTime ToDate, int ReportCategory, int ReportType);

        DataSet DownloadUserManagementReport(DateTime FromDate, DateTime ToDate, int ReportCategory, int ReportType);
        
        

        List<CommonReport> SearchTicketManagementReport(DateTime fromDate, DateTime toDate, int reportCategory, int reportType);
       
        
        
        List<CommonReport> SearchWarrentyManagementReport(DateTime FromDate, DateTime ToDate, int ReportCategory, int ReportType);

        List<ReportList> LoadAuditTrialTypes();
        List<CommonReport> SearchAuditTrialReport(DateTime FromDate, DateTime ToDate, int ReportType);

    }
}