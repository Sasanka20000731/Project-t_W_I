using PeojectTWI.Data;
using PeojectTWI.Models;
using PeojectTWI.Services.InventoryService;
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
    public class InventoryController : Controller
    {
        ProjectDBEntities db = new ProjectDBEntities();
        private IUserService _userService;
        private ITicketService _ticketService;
        private IInventoryService _inventoryService;
        private IWarrentyService _warrentyService;

        public InventoryController()
        {
            _userService = new UserService();
            _ticketService = new TicketService();
            _inventoryService = new InventoryService();
            _warrentyService = new WarrentyService();
        }

        public ActionResult insertProductCategory()
        {
       
            return View();
        }

        [HttpPost]
        public ActionResult insertProductCategory(productCategory pd)
        {
            _inventoryService.insertProductCategory( pd.BrandName, pd.VendorName, pd.VendorContact, pd.VendorEmail, pd.VendorAddress, pd.ProductName);
            return View();
        }

        public ActionResult viewProductCategories()
        {
            var pdc = _inventoryService.viewProductCategories();
            //var pdc = db.tblProductCategories;
            return View(pdc);
        }

        public ActionResult editProductCategory()
        {
            var id = Request["pid"];
            int pid = Convert.ToInt32(id);
            var a = _inventoryService.getProductCategoryDetails(pid);

            return View(a);
        }

        [HttpPost]
        public ActionResult updateProductCategory(productCategory pdc)
        {

            try
            {
                _inventoryService.updateProductCategory(pdc.ProductID, pdc.BrandName, pdc.VendorName, pdc.VendorContact, pdc.VendorEmail, pdc.VendorAddress, pdc.Active, pdc.ProductName);
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Error updating user: " + ex.Message;
                return RedirectToAction("viewProductCategories");
            }
            return RedirectToAction("viewProductCategories");

        }

        public ActionResult deleteProductCategory()
        {
            var id = Request["pidDelete"];
            int pid = Convert.ToInt32(id);
            var a = _inventoryService.getProductCategoryDetails(pid);

            return View(a);
        }

        public ActionResult RemoveProductCategory()
        {
            var id = Request["pidDelete"];
            int pid = Convert.ToInt32(id);
             _inventoryService.deleteProductCategory(pid);

            return View("viewProductCategories");

        }

        public ActionResult insertMasterStore()
        {
            masterStore mss = new masterStore();
            using (var context = new ProjectDBEntities())
            {
                mss.ProductList = context.tblProductCategories
                .Where(m => m.Active == true)
                .Select(m => new Product
                {
                    ProductCategoryID = m.ProductID,
                    ProductName = m.ProductName
                }).ToList();
            }
            return View(mss);
        }

        [HttpPost]
        public ActionResult insertMasterStore(masterStore ms)
        {
            _inventoryService.insertMasterStore(ms.ProductId, ms.perchesedCount, ms.unitPrice, ms.PerchesedDate);
            masterStore mss = new masterStore();
            using (var context = new ProjectDBEntities())
            {
                mss.ProductList = context.tblProductCategories
                .Where(m => m.Active == true)
                .Select(m => new Product
                {
                    ProductCategoryID = m.ProductID,
                    ProductName = m.ProductName
                }).ToList();
            }
 


            return View(mss);
        }

        public ActionResult viewtMasterStore()
        {
            var pdc = _inventoryService.viewMasterStore();
            return View(pdc);
        }

        public ActionResult editMasterStore()
        {
            var id = Request["msid"];
            int mid = Convert.ToInt32(id);
            var a = _inventoryService.getMasterStoreDetails(mid);

            return View(a);
        }

        [HttpPost]
        public ActionResult updateMasterStore(masterStore ms)
        {

            try
            {
                _inventoryService.updateMasterStore(ms.mStoreId, ms.ProductId, ms.perchesedCount, ms.unitPrice, ms.PerchesedDate, ms.RecoredEnterdBy);
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Error updating user: " + ex.Message;
                return RedirectToAction("viewtMasterStore");
            }
            return RedirectToAction("viewtMasterStore");

        }

        public ActionResult deleteMasterStore()
        {
            var id = Request["msIDDelete"];
            int mid = Convert.ToInt32(id);
            var a = _inventoryService.getMasterStoreDetails(mid);

            return View(a);
        }

        public ActionResult removeMasterStore()
        {
            var id = Request["msDeleteid"];
            int msid = Convert.ToInt32(id);
            _inventoryService.deleteMasterData(msid);
            return RedirectToAction("viewtMasterStore");
        }


        public ActionResult WareHouseManage()
        {     
            return View();
        }

        public JsonResult GetProductCategoryValues()
        {
            var ProdcutCategory = _inventoryService.GetProductCategoryValues();
            return Json(ProdcutCategory, JsonRequestBehavior.AllowGet);
        }
        //public JsonResult GetmasterStoreValues()
        //{
        //    var MasterStore = _inventoryService.GetmasterStoreValues();
        //    return Json(MasterStore, JsonRequestBehavior.AllowGet);
        //}

        public JsonResult CheckExist(int dataType, int ProductCategory, string SerialNo)
        {
            var ExsistReslut = _inventoryService.CheckExsist(dataType, ProductCategory, SerialNo);

            return Json(ExsistReslut, JsonRequestBehavior.AllowGet);
        }


        public JsonResult ManageWareHouseData(int dataType,int ProductCategory,  string SerialNo)
        {
            var whmanageReslut = _inventoryService.ManageWareHouseData(dataType, ProductCategory, SerialNo);

            return Json(whmanageReslut, JsonRequestBehavior.AllowGet);
        }



        public ActionResult ViewWareHouse()
        {
            return View();
        }

        public JsonResult ViewWareHousedata(DateTime? FromDate = null, DateTime? Todate = null) 
        {
            List<WHmanage> WHList = _inventoryService.ViewWareHousedata(FromDate, Todate);
            return Json(WHList,JsonRequestBehavior.AllowGet);        
        }

    }
}