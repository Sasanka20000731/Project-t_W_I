using PeojectTWI.Data;
using PeojectTWI.Models;
using PeojectTWI.Services.InventoryService;
using PeojectTWI.Services.SaleService;
using PeojectTWI.Services.TicketService;
using PeojectTWI.Services.UserService;
using PeojectTWI.Services.WarrentyService;
using PeojectTWI.Services.ReportService;
using PeojectTWI.Services.OtherServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CrystalDecisions.CrystalReports.Engine;
using System.IO;

namespace PeojectTWI.Controllers
{
    public class ReportController : Controller
    {
        ProjectDBEntities db = new ProjectDBEntities();
        private IUserService _userService;
        private ITicketService _ticketService;
        private IInventoryService _inventoryService;
        private IWarrentyService _warrentyService;
        private ISaleService _saleService;
        private IReportService _reportService;
        private IOtherServices _otherServices;

        public ReportController()
        {
            _userService = new UserService();
            _ticketService = new TicketService();
            _inventoryService = new InventoryService();
            _warrentyService = new WarrentyService();
            _saleService = new SaleService();
            _reportService = new ReportService();
            _otherServices = new OtherServices();
        }

        public ActionResult UserManagementReportForm()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            return View();
        }
        public JsonResult LoadReportDropDownData(int ReportCategory)
        {
            var result = _reportService.LoadUserManagementReportData(ReportCategory);

            return Json(result, JsonRequestBehavior.AllowGet);

        }
        public JsonResult SearchUserManagementReport(DateTime FromDate, DateTime ToDate, int ReportCategory, int ReportType)
        {
            var result = _reportService.SearchUserManagementReport(FromDate,ToDate, ReportCategory, ReportType);

            return Json(result, JsonRequestBehavior.AllowGet);

        }

        public ActionResult DownloadUserManagementReport(string FromDate, string ToDate, int ReportCategory, string ReportType)
        {
            DateTime fromDate = DateTime.Parse(FromDate);
            DateTime toDate = DateTime.Parse(ToDate);
            var userReportDs = _reportService.DownloadUserManagementReport(fromDate, toDate, ReportCategory, Convert.ToInt32(ReportType));

            ReportDocument rd = new ReportDocument();
            rd.Load(Path.Combine(Server.MapPath("~/Reports/Crystal_Reports/RptUserManagement.rpt")));
            rd.SetDataSource(userReportDs.Tables["UserManagementDataTable"]);

            Response.Buffer = false;
            Response.ClearContent();
            Response.ClearHeaders();

            Stream stream = rd.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            stream.Seek(0, SeekOrigin.Begin);
            return File(stream, "application/pdf", "UserManagementReport.pdf");

        }


        public ActionResult InventoryManagementReportForm()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            return View();
        }
        public JsonResult SearchInventoryManagementReport(DateTime FromDate, DateTime ToDate, int ReportCategory, int ReportType)
        {
            var result = _reportService.InventoryManagementReport(FromDate,ToDate,ReportCategory,ReportType);

            return Json(result, JsonRequestBehavior.AllowGet);

        }

        public ActionResult DownloadInventoryManagementReport(string FromDate, string ToDate, int ReportCategory, string ReportType)
        {
            DateTime fromDate = DateTime.Parse(FromDate);
            DateTime toDate = DateTime.Parse(ToDate);
            var inventoryReportDs = _reportService.DownloadCommonManagementReport(fromDate, toDate, ReportCategory, Convert.ToInt32(ReportType));

            ReportDocument rd = new ReportDocument();
            rd.Load(Path.Combine(Server.MapPath("~/Reports/Crystal_Reports/RptInventoryManagement.rpt")));
            rd.SetDataSource(inventoryReportDs.Tables["CommonDataTable"]);

            Response.Buffer = false;
            Response.ClearContent();
            Response.ClearHeaders();

            Stream stream = rd.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            stream.Seek(0, SeekOrigin.Begin);
            return File(stream, "application/pdf", "InventoryManagementReport.pdf");

        }




        public ActionResult TicketManagementReportForm()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            return View();
        }
        public JsonResult SearchTicketManagementReport(DateTime FromDate, DateTime ToDate, int ReportCategory, int ReportType)
        {
            var result = _reportService.SearchTicketManagementReport(FromDate, ToDate, ReportCategory, ReportType);
            return Json(result, JsonRequestBehavior.AllowGet);

        }

        public ActionResult DownloadTicketManagementReport(string FromDate, string ToDate, int ReportCategory, string ReportType)
        {
            DateTime fromDate = DateTime.Parse(FromDate);
            DateTime toDate = DateTime.Parse(ToDate);
            var inventoryReportDs = _reportService.DownloadCommonManagementReport(fromDate, toDate, ReportCategory, Convert.ToInt32(ReportType));

            ReportDocument rd = new ReportDocument();
            rd.Load(Path.Combine(Server.MapPath("~/Reports/Crystal_Reports/RptTicketManagement.rpt")));
            rd.SetDataSource(inventoryReportDs.Tables["CommonDataTable"]);

            Response.Buffer = false;
            Response.ClearContent();
            Response.ClearHeaders();

            Stream stream = rd.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            stream.Seek(0, SeekOrigin.Begin);
            return File(stream, "application/pdf", "TicketManagementReport.pdf");

        }




        public ActionResult WarrentyManagementReportForm()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            return View();
        }
        public JsonResult SearchWarrentyManagementReport(DateTime FromDate, DateTime ToDate, int ReportCategory, int ReportType)
        {
            var result = _reportService.SearchWarrentyManagementReport(FromDate, ToDate, ReportCategory, ReportType);
            return Json(result, JsonRequestBehavior.AllowGet);

        }
        public ActionResult OtherReportForm()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            return View();
        }
        public ActionResult AuditTrialReportForm()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            return View();
        }        

        public JsonResult LoadAuditTrialTypes()
        {
            var result = _reportService.LoadAuditTrialTypes();
            return Json(result, JsonRequestBehavior.AllowGet);

        }
        public JsonResult SearchAuditTrialReport(DateTime FromDate, DateTime ToDate, int ReportType)
        {
            var result = _reportService.SearchAuditTrialReport(FromDate, ToDate, ReportType);
            return Json(result, JsonRequestBehavior.AllowGet);

        }


    }
}