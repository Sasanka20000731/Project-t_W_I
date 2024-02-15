using PeojectTWI.Data;
using PeojectTWI.Services.InventoryService;
using PeojectTWI.Services.TicketService;
using PeojectTWI.Services.UserService;
using PeojectTWI.Services.WarrentyService;
using PeojectTWI.Services.SaleService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PeojectTWI.Controllers
{
    public class TicketController : Controller
    {

        ProjectDBEntities db = new ProjectDBEntities();
        private IUserService _userService;
        private ITicketService _ticketService;
        private IInventoryService _inventoryService;
        private IWarrentyService _warrentyService;
        private ISaleService _saleService;

        public TicketController()
        {
            _userService = new UserService();
            _ticketService = new TicketService();
            _inventoryService = new InventoryService();
            _warrentyService = new WarrentyService();
            _saleService = new SaleService();
        }


        public ActionResult AddTicket()
        {
            return View();
        }

        public JsonResult InsertTicket(string SerialNumber, string TicketRemark)
        {
            var LoggedUser = Session["LoggedUserID"];

            var result = _ticketService.AddTicket(SerialNumber, TicketRemark, Convert.ToInt32(LoggedUser));

            return Json(result, JsonRequestBehavior.AllowGet);
        }


        public ActionResult AssignTicket()
        {
            var tickets = db.tblTickets;
            return View(tickets);
        }




        public ActionResult AssignTicketTolevel(int Ticketid)
        {
      
            var result = _ticketService.GetTicketDetailsToassign(Ticketid).FirstOrDefault();

            return View(result);
        }



        public JsonResult GetTicketHandlers()
        {
            var result = _ticketService.GetTicketHandlers();

            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AssignTicketToHandler(int TicketID, int AssignToUsrer)
        {
            var LoggedUser = Session["LoggedUserID"];
            var result = _ticketService.AssignTicketToHandler(TicketID, AssignToUsrer,Convert.ToInt32(LoggedUser));
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ManageTicket()
        {
            return View();
        }

        //public ActionResult DownloadPipelineReport(string MasterId, int regionId, string selectedDateandYear)
        //{
        //    DateTime Selecteddate = Convert.ToDateTime(selectedDateandYear);
        //    string[] array = MasterId.Split('_');

        //    DataSet PipelineReportDataset = Selecteddate.Day == DateTime.Today.Day ? _pipelineService.DownloadReportCurrentMonth(array[0].ToString(), regionId, Convert.ToInt32(array[1])) :
        //    _pipelineService.DownloadReport(array[0].ToString(), regionId, Convert.ToInt32(array[1]), Selecteddate.Day, Selecteddate.Month, Selecteddate.Year);

        //    string rptTypeSummary = MasterId != "00000_0" ? "Report of : " + PipelineReportDataset.Tables["Table1"].Rows[0]["Branch"].ToString()
        //    : regionId != 0 ? "Report of " + PipelineReportDataset.Tables["Table1"].Rows[0]["Region"].ToString() : "All";

        //    string rptMonth = Selecteddate.Day == DateTime.Today.Day ? DateTime.Today.Month.ToString() + "/" + DateTime.Today.Day.ToString() + "/" + DateTime.Today.Year.ToString()
        //        : Selecteddate.Month + "/" + Selecteddate.Day + "/" + Selecteddate.Year;

        //    var a = PipelineReportDataset;
        //    ReportDocument rd = new ReportDocument();
        //    rd.Load(Path.Combine(Server.MapPath("~/Rpt/CrystalReport/PipelineReport.rpt")));
        //    rd.SetDataSource(PipelineReportDataset.Tables["Table1"]);
        //    rd.SetParameterValue(0, rptMonth);
        //    rd.SetParameterValue(1, rptTypeSummary);
        //    Stream stream = rd.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
        //    stream.Seek(0, SeekOrigin.Begin);
        //    return File(stream, "application/pdf", "PrinterListReport.pdf");
        //}

        public JsonResult LogadPendingTickets()
        {
            var LoggedUser = Session["LoggedUserID"];
            var result = _ticketService.LogadPendingTickets(5);

           // var result = _ticketService.LogadPendingTickets(Convert.ToInt32(LoggedUser));
            
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult getTicketDetailsPage(int ticketID)
        {
            ViewBag.ticketID = ticketID;
            return View();
        }

        public JsonResult LoadTicketdetailsToManage(int TicketId)
        {
            var result = _ticketService.LogadPendingTickets(5);

            // var result = _ticketService.LogadPendingTickets(Convert.ToInt32(LoggedUser));

            return Json(result, JsonRequestBehavior.AllowGet);
        }





    }
}
