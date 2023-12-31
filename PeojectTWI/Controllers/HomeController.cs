using PeojectTWI.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;
using System.Data.SqlClient;
using PeojectTWI.Data;
using PeojectTWI.Services.UserService;
using PeojectTWI.Services.TicketService;
using PeojectTWI.Services.InventoryService;
using PeojectTWI.Services.WarrentyService;

namespace PeojectTWI.Controllers
{
    public class HomeController : Controller
    {
        //Database entity object
        ProjectDBEntities db = new ProjectDBEntities();
        private IUserService _userService;
        private ITicketService _ticketService;
        private IInventoryService _inventoryService;
        private IWarrentyService _warrentyService;

        public HomeController()
        {
            _userService = new UserService();
            _ticketService = new TicketService();
            _inventoryService = new InventoryService();
            _warrentyService = new WarrentyService();
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult addUser()
        {
            return View();
        }

        [HttpPost]
        public ActionResult addUser(user user)
        {
            _userService.addUser(user.UserName, user.FirstName, user.LastName, user.UserLevel, user.MobileNumber, user.Email, user.DOB);
            ModelState.Clear();
            return View("addUser", user);
        }

        public ActionResult viewUser()
        {
            var user = db.tblUsers;
            return View(user);
        }

        public ActionResult updateUser(user u)
        {
            var id = Request["uid"];
            int uid = Convert.ToInt32(id);
            tblUser TU = db.tblUsers.SingleOrDefault(x => x.UserId == uid);
            u.UserId = TU.UserId;
            u.UserName = TU.UserName;
            u.FirstName = TU.FirstName;
            u.LastName = TU.LastName;
            u.MobileNumber = TU.MobileNumber;
            u.UserLevel = TU.UserLevel;
            u.DOB = TU.DOB;
            return View("updateUser", u);
        }

        [HttpPost]
        public ActionResult updateUsers(user user)
        {
            try
            {
                var a = _userService.updateUser(user.UserId, user.UserName, user.FirstName, user.LastName, user.UserLevel, user.MobileNumber, user.Email, user.DOB);
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Error updating user: " + ex.Message;
                return View("Index");
            }
        }

        public ActionResult userAccountStatus(user uAD)
        {
            var id = Request["uid_Status"];
            int uid = Convert.ToInt32(id);
            tblUser TU = db.tblUsers.SingleOrDefault(x => x.UserId == uid);
            uAD.UserId = TU.UserId;
            uAD.UserName = TU.UserName;
            uAD.FirstName = TU.FirstName;
            uAD.LastName = TU.LastName;
            uAD.MobileNumber = TU.MobileNumber;
            uAD.UserLevel = TU.UserLevel;
            uAD.DOB = TU.DOB;
            return View("userAccountStatus", uAD);

        }

        [HttpPost]
        public ActionResult userAccountStatusChange(user user)
        {
            try
            {
                var a = _userService.changeUserStatus(user.UserId, user.Active);
                return RedirectToAction("Index");

            }
            catch (Exception ex)
            {
                ViewBag.Error = "Error updating user: " + ex.Message;
                return View();
            }

        }






    }
}