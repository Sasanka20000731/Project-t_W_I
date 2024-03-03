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

        public ActionResult Login()
        {
            return View();
        }

        public JsonResult VerifyUser(string UserName)
        {
            var user = _userService.checkValidUser(UserName);
            return Json(user, JsonRequestBehavior.AllowGet);
        }

        public JsonResult loginUser(string UserName, string Password)
        {
            var logUser = _userService.loginUser(UserName, Password);

            if (logUser == 1)
            {
                var a = _userService.GetLoggedUsers(UserName, Password);
                Session["LoggedUserID"] = a[0].UserId;
                return Json(logUser, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(logUser, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult LogOut()
        {
            Session.Clear();
            Session.Abandon();
            return RedirectToAction("Login", "Home"); // Redirect to the home page after logout
     
        }

        public ActionResult Index()
        {
            var aa = Session["LoggedUserID"];
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            return View();
        }

        public ActionResult addUser()
        {
            var aa = Session["LoggedUserID"];
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");

            }
            return View();
        }

        public JsonResult getUserLlevels()
        {
            var aa = _userService.getUserlevels();
            return Json(aa, JsonRequestBehavior.AllowGet);
        }

        public JsonResult saveUser(string UserName, string FirstName, string LastName,DateTime DOB,string Email,string MobileNumber,int UserLevel)
        {
            var result =   _userService.addUser(UserName, FirstName, LastName, UserLevel, MobileNumber, Email, DOB);
            return Json(result, JsonRequestBehavior.AllowGet);
           
        }

        public ActionResult viewUser()
        {
            var aa = Session["LoggedUserID"];
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");

            }

            var user = db.tblUsers;
            return View(user);
        }

        public ActionResult updateUser()
        {
            var aa = Session["LoggedUserID"];
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");

            }
            var id = Request["uid"];
            ViewBag.UserId = id;
            return View();
        }


        public JsonResult getselectedUserDetails(int UserId)
        {
            var result = _userService.getselectedUserDetails(UserId);
            return Json(result, JsonRequestBehavior.AllowGet);

        }



        
        public ActionResult updateUsers(int UserId, string UserName, string FirstName, string LastName, DateTime DOB,string Email, string MobileNumber, int UserLevel, bool Active)
        {

            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");

            }

            try
            {
                var a = _userService.updateUser(UserId, UserName, FirstName, LastName, UserLevel, MobileNumber, Email, DOB);
                return RedirectToAction("viewUser");
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Error updating user: " + ex.Message;
                return View("viewUser");
            }
        }

        public ActionResult userAccountStatus(user uAD)
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");

            }
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
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");

            }
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