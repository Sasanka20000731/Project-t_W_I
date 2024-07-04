﻿using PeojectTWI.Data;
using PeojectTWI.Services.InventoryService;
using PeojectTWI.Services.SaleService;
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
    public class SaleController : Controller
    {

        ProjectDBEntities db = new ProjectDBEntities();
        private IUserService _userService;
        private ITicketService _ticketService;
        private IInventoryService _inventoryService;
        private IWarrentyService _warrentyService;
        private ISaleService _saleService;
        private IOtherServices _otherServices;
        Email email = new Email();
        public SaleController()
        {
            _userService = new UserService();
            _ticketService = new TicketService();
            _inventoryService = new InventoryService();
            _warrentyService = new WarrentyService();
            _saleService = new SaleService();
            _otherServices = new OtherServices();


           // var accessForms = _userService.loadAccessForms();
           // ViewBag.AccessForms = accessForms;
        }

        public ActionResult SaleItem()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            return View();
        }

        public ActionResult RejectSaleItem()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            return View();
        }

        public JsonResult GetProductDetailsToSale(string SerialNo)
        {

            var ProductDetails = _saleService.GetItemDetailsTosale(SerialNo);

            return Json(ProductDetails, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveSaleItem(string cName, string cContact, string CustomerEmail, string cAddress, string SerialNo, decimal Discount , decimal Price, int Warrenty)
        {

            string[] Names = cName.Split(' ');
            var user = _userService.addUser(Names[0].ToString(), Names[0].ToString(), Names[1].ToString(), 7,cContact, CustomerEmail, null);
            int UserId = _userService.getCustomerID(Names[0].ToString());

            int warranty = (Warrenty == 1) ? 12 : (Warrenty == 2) ? 24 : (Warrenty == 3) ? 36 : 0;
            var result = _saleService.saveSaleItem(cName,cContact, CustomerEmail, cAddress,SerialNo,Discount,Price, warranty,UserId);
            email.SendEmail(CustomerEmail, "testingbranchuser@gmail.com", "xclczwvfajxxpzeo", "User Login", "Dear " + Names[0].ToString() + ". Your User Name is : " + Names[0].ToString() + " and Password is : 123456789");
           
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetSoldItemDataTable(string SerialNo = null, string InvoiceNo = null, string ContactNo = null)
        {
            var result = SerialNo != null ? _saleService.GetSoldItemData(SerialNo, null, null)
                 : InvoiceNo != null ? _saleService.GetSoldItemData(null, Convert.ToInt32(InvoiceNo), null) :
                  _saleService.GetSoldItemData(null, null, ContactNo);
           // var result = _saleService.GetSoldItemData(SerialNo,Convert.ToInt32(InvoiceNo),ContactNo);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetSelectedSoldItemData(string SerialNo = null, string InvoiceNo = null, string ContactNo = null)
        {
            var result = _saleService.GetSelectedSoldItemData(SerialNo);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public JsonResult RejectSale(string SerialNumber)
        {
            var RejectItemResult = _saleService.RejectSaleItem(SerialNumber);
            return Json(RejectItemResult, JsonRequestBehavior.AllowGet);
        }

    }
}