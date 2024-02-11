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

    }
}