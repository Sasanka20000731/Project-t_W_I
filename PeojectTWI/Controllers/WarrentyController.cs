﻿using PeojectTWI.Data;
using PeojectTWI.Services.InventoryService;
using PeojectTWI.Services.TicketService;
using PeojectTWI.Services.UserService;
using PeojectTWI.Services.WarrentyService;
using PeojectTWI.Services.OtherServices;
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
        private IOtherServices _otherServices;

        public WarrentyController()
        {
            _userService = new UserService();
            _ticketService = new TicketService();
            _inventoryService = new InventoryService();
            _warrentyService = new WarrentyService();
            _otherServices = new OtherServices();


            //var accessForms = _userService.loadAccessForms();
            //ViewBag.AccessForms = accessForms;
        }

        public ActionResult ViewAllWerrenty()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            var warrenty = db.tblMasterWarrenties;
            return View(warrenty);
        }
 
        public ActionResult CheckWarrenty() 
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
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

        public ActionResult ExtendWarrenty(string SerialNumber)
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            ViewBag.SerialNumber = SerialNumber;
            return View();
        }


        public JsonResult SaveExtenWarrenty(string SerialNumber,int Warrenty, decimal ExtendCost)
        {
        
            int warranty = (Warrenty == 1) ? 12 : (Warrenty == 2) ? 24 : (Warrenty == 3) ? 36 : 0;


            var Result = _warrentyService.SaveExtenWarrenty(SerialNumber, warranty, ExtendCost);
            return Json(Result, JsonRequestBehavior.AllowGet);
        }



    }
}