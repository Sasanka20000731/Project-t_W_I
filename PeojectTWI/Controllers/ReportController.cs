using PeojectTWI.Data;
using PeojectTWI.Models;
using PeojectTWI.Services.InventoryService;
using PeojectTWI.Services.SaleService;
using PeojectTWI.Services.TicketService;
using PeojectTWI.Services.UserService;
using PeojectTWI.Services.WarrentyService;
using PeojectTWI.Services.ReportService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;


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

        public ReportController()
        {
            _userService = new UserService();
            _ticketService = new TicketService();
            _inventoryService = new InventoryService();
            _warrentyService = new WarrentyService();
            _saleService = new SaleService();
            _reportService = new ReportService();
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

        public ActionResult TicketManagementReportForm()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            return View();
        }
        public ActionResult WarrentyManagementReportForm()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            return View();
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


    }
}