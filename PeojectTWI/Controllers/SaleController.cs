using PeojectTWI.Data;
using PeojectTWI.Services.InventoryService;
using PeojectTWI.Services.SaleService;
using PeojectTWI.Services.TicketService;
using PeojectTWI.Services.UserService;
using PeojectTWI.Services.WarrentyService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

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

        public SaleController()
        {
            _userService = new UserService();
            _ticketService = new TicketService();
            _inventoryService = new InventoryService();
            _warrentyService = new WarrentyService();
            _saleService = new SaleService();
        }

        public ActionResult SaleItem()
        {
            return View();
        }

        public ActionResult RejectSaleItem()
        {
            return View();
        }


        public JsonResult GetProductDetailsToSale(string SerialNo)
        {
            var ProductDetails = _saleService.GetItemDetailsTosale(SerialNo);

            return Json(ProductDetails, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveSaleItem(string cName, string cContact, string cEmail, string cAddress, string SerialNo, decimal Discount , decimal Price, int Warrenty)
        {
            
            int warranty = (Warrenty == 1) ? 12 : (Warrenty == 2) ? 24 : (Warrenty == 3) ? 36 : 0;


            var result = _saleService.saveSaleItem(cName,cContact,cEmail,cAddress,SerialNo,Discount,Price, warranty);

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

    }
}