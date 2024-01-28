using PeojectTWI.Data;
using PeojectTWI.Services.InventoryService;
using PeojectTWI.Services.TicketService;
using PeojectTWI.Services.UserService;
using PeojectTWI.Services.WarrentyService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PeojectTWI.Models;

namespace PeojectTWI.Controllers
{
    public class WarrentyController : Controller
    {
        ProjectDBEntities db = new ProjectDBEntities();
        private IUserService _userService;
        private ITicketService _ticketService;
        private IInventoryService _inventoryService;
        private IWarrentyService _warrentyService;

        public WarrentyController()
        {
            _userService = new UserService();
            _ticketService = new TicketService();
            _inventoryService = new InventoryService();
            _warrentyService = new WarrentyService();
        }
    
        public ActionResult ViewAllWerrenty()
        {
            var warrenty = db.tblMasterWarrenties;
            return View(warrenty);
        }
 
        public ActionResult CheckWarrenty() 
        {

            return View();
        }
        public JsonResult GetWarrentyList(string ContactNumber)
        {
            var WarrentyList = _warrentyService.GetWarrentyList(ContactNumber);
            return Json(WarrentyList, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetWarrentyCommentList(string SerialNumber)
        {
            var WarrentyCommentList = _warrentyService.GetWarrentyComments(SerialNumber);
            return Json(WarrentyCommentList, JsonRequestBehavior.AllowGet);
        }



    }
}