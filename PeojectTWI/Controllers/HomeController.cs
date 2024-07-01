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
using PeojectTWI.Services.OtherServices;


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
        private IOtherServices _otherServices;

        public HomeController()
        {
            _userService = new UserService();
            _ticketService = new TicketService();
            _inventoryService = new InventoryService();
            _warrentyService = new WarrentyService();
            _otherServices = new OtherServices();

        
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
            string ValidPassword = _userService.EncryptText(Password);
            var logUser = _userService.loginUser(UserName, ValidPassword);

            if (logUser == 1)
            {
                var a = _userService.GetLoggedUsers(UserName, ValidPassword);
                Session["LoggedUserID"] = a[0].UserId;

                var accessForms = _userService.loadAccessForms(Convert.ToInt32(Session["LoggedUserID"]));
                HttpContext.Session["AccessForm"] = accessForms;
                ViewBag.AccessForms = accessForms;


                _otherServices.InsertAuditTrial(5, "Logged In User " + UserName, Convert.ToInt32(Session["LoggedUserID"]));
                return Json(logUser, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(logUser, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult LogOut()
        {
            _otherServices.InsertAuditTrial(5, "Log Out User.", Convert.ToInt32(Session["LoggedUserID"]));
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

        public JsonResult loadDashbordDetails()
        {
            var result = _otherServices.LoadDashbord(Convert.ToInt32(Session["LoggedUserID"]));

            return Json(result, JsonRequestBehavior.AllowGet);

        }

        public JsonResult loadDashbordChart()
        {
            var result = _otherServices.LoadDashbordChart();

            return Json(result, JsonRequestBehavior.AllowGet);

        }

        public ActionResult addUser()
        {
            var aa = Session["LoggedUserID"];
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");

            }
        
            _otherServices.InsertAuditTrial(4, "Load User Creation Page", Convert.ToInt32(Session["LoggedUserID"]));
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
            var zresult = CommonEmail(Email, "testingbranchuser@gmail.com", "xclczwvfajxxpzeo", "User Login", "Dear "+FirstName+" "+LastName+". Your User Name is : "+UserName+" and Password is : 123456789");
            _otherServices.InsertAuditTrial(1, "Inseted New User ("+UserName+")", Convert.ToInt32(Session["LoggedUserID"]));
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult viewUser()
        {
            var aa = Session["LoggedUserID"];
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");

            }
            _otherServices.InsertAuditTrial(4, "Load View Users Page", Convert.ToInt32(Session["LoggedUserID"]));
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

            _otherServices.InsertAuditTrial(4, "Load Update User Page", Convert.ToInt32(Session["LoggedUserID"]));
            return View();
        }

        public JsonResult getselectedUserDetails(int UserId)
        {
            var result = _userService.getselectedUserDetails(UserId);
            return Json(result, JsonRequestBehavior.AllowGet);

        }

        public JsonResult updateUsers(string UserId, string UserName, string FirstName, string LastName, DateTime DOB,string Email, string MobileNumber, int UserLevel, bool Active)
        {


      
            var result = _userService.UpdateUser(Convert.ToInt32(UserId), UserName, FirstName, LastName, UserLevel, MobileNumber, Email, DOB, Active);
            _otherServices.InsertAuditTrial(2, "Updated User ("+UserName+")", Convert.ToInt32(Session["LoggedUserID"]));
            return Json(result, JsonRequestBehavior.AllowGet);
     
        }

        public bool CommonEmail(string toMail,string fromMail, string password,string subject,string body) 
        {
            //try
            //{
            //From mail Password "xclczwvfajxxpzeo"
            //HO@vfplc
            //From Mail = testingbranchuser@gmail.com
            // var toMail = "sasankabuddhi@gmail.com";
            Email email = new Email();
                email.SendEmail(toMail,fromMail,password,subject,body);

                return true;
            //}
            //catch (Exception e)
            //{
            //    Console.WriteLine(e);
            //    return false;
            //}

        }

        public bool CheckValidEmail(string EmailAddress)
        {
            Email email = new Email();
            bool result =  email.IsValidEmail(EmailAddress);

            return result;
        }

        public ActionResult ViewProfile()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");

            }
            _otherServices.InsertAuditTrial(4, "View User Profile", Convert.ToInt32(Session["LoggedUserID"]));
            return View();

        }

        public ActionResult ViewAudiTrail()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");

            }
            _otherServices.InsertAuditTrial(4, "View Audit Trial Page", Convert.ToInt32(Session["LoggedUserID"]));

            return View();

        }

        public JsonResult loadUserProfileDetails()
        {
            var result = _userService.loggedUserDetails(Convert.ToInt32(Session["LoggedUserID"]));

            result[0].stringDOB = Convert.ToDateTime(result[0].DOB).ToString("MM/dd/yyyy");


            result[0].Password = _userService.DecryptText(result[0].Password);

            return Json(result, JsonRequestBehavior.AllowGet);

        }

        public JsonResult UpdateUserProfile(string FirstName, string LastName)
        {
            var result = _userService.UpdateUserProfile(Convert.ToInt32(Session["LoggedUserID"]), FirstName, LastName);

            return Json(result, JsonRequestBehavior.AllowGet);

        }

        public ActionResult GetChartData()
        {

            var result = _userService.LoadPieChartData();
            
            return Json(result, JsonRequestBehavior.AllowGet);
        }


    }
}