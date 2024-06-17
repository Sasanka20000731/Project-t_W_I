using PeojectTWI.Data;
using PeojectTWI.Models;
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

namespace PeojectTWI.Controllers
{
    public class InventoryController : Controller
    {
        ProjectDBEntities db = new ProjectDBEntities();
        private IUserService _userService;
        private ITicketService _ticketService;
        private IInventoryService _inventoryService;
        private IWarrentyService _warrentyService;
        private IOtherServices _otherServices;
        Email email = new Email();
        public InventoryController()
        {
            _userService = new UserService();
            _ticketService = new TicketService();
            _inventoryService = new InventoryService();
            _warrentyService = new WarrentyService();
            _otherServices = new OtherServices();


             // var accessForms = _userService.loadAccessForms();
          //  ViewBag.AccessForms = accessForms;

        }


        public ActionResult insertProductCategory()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            return View();
        }






        public JsonResult SaveProductCategory(string ProductName,string BrandName, string VendorName,string VendorContact,string VendorAddress,string VendorEmail)
        {

            var user = _userService.addUser(VendorName, VendorName, BrandName, 6, VendorContact, VendorEmail, null);
            int VendorID = _userService.getVendorID(VendorName);

            var result = _inventoryService.insertProductCategory( BrandName, VendorName, VendorContact, VendorEmail, VendorAddress, ProductName, VendorID);
           
          
            email.SendEmail(VendorEmail, "testingbranchuser@gmail.com", "xclczwvfajxxpzeo", "User Login", "Dear " + VendorName + ". Your User Name is : " + VendorName + " and Password is : 123456789");

            return Json(result, JsonRequestBehavior.AllowGet);
       
        }

        public ActionResult viewProductCategories()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            var pdc = _inventoryService.viewProductCategories();
            //var pdc = db.tblProductCategories;
            return View(pdc);
        }

        public ActionResult editProductCategory()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            var id = Request["pid"];
            ViewBag.ProductID = id;
            return View();
        }


        public JsonResult getselectedProductCategoryDetails(int ProductID)
        {
            var result = _inventoryService.getProductCategoryDetails(ProductID);
            return Json(result, JsonRequestBehavior.AllowGet);
        }



        public ActionResult EditProductCategorys(int ProductID,string BrandName, string VendorName, string VendorContact, string VendorEmail, string VendorAddress, bool Active, string ProductName)
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            try
            {
                _inventoryService.updateProductCategory(ProductID, BrandName, VendorName, VendorContact,VendorEmail, VendorAddress, Active, ProductName);
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
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            var id = Request["pidDelete"];
            int pid = Convert.ToInt32(id);
            var a = _inventoryService.getProductCategoryDetails(pid)[0];

            return View(a);
        }

        public ActionResult RemoveProductCategory()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            var id = Request["pidDelete"];
            int pid = Convert.ToInt32(id);
             _inventoryService.deleteProductCategory(pid);

          //  return View("viewProductCategories");
            return RedirectToAction("viewProductCategories", "Inventory");

        }

        public ActionResult insertMasterStore()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }

            masterStore mss = new masterStore();
            using (var context = new ProjectDBEntities())
            {
                var excludedProductIds = context.tblMasterStores.Select(ms => ms.ProductId).ToList();

                mss.ProductList = context.tblProductCategories
                    .Where(m => m.Active == true && !excludedProductIds.Contains(m.ProductID))
                    .Select(m => new Product
                    {
                        ProductCategoryID = m.ProductID,
                        ProductName = m.ProductName
                    })
                    .ToList();
            }


            return View(mss);
        }

        [HttpPost]
        public ActionResult insertMasterStore(masterStore ms)
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }

         //   DateTime? ss = ms.PerchesedDate;
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

            ModelState.Clear();
            return View(mss);
        }

        public ActionResult viewtMasterStore()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            var pdc = _inventoryService.viewMasterStore();
            return View(pdc);
        }

        public ActionResult editMasterStore()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            var id = Request["msid"];
            int mid = Convert.ToInt32(id);
            var a = _inventoryService.getMasterStoreDetails(mid);

            return View(a);
        }

        [HttpPost]
        public ActionResult updateMasterStore(masterStore ms)
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            try
            {
                DateTime? PerchesedDate = ms.PerchesedDate == null ? Convert.ToDateTime(ms.PerchesedDateString) : ms.PerchesedDate;
                _inventoryService.updateMasterStore(ms.mStoreId, ms.perchesedCount, ms.unitPrice, PerchesedDate);
            }
            catch (Exception ex)
            {
                ViewBag.Error = "Error updating user: " + ex.Message;
                return RedirectToAction("editMasterStore");
            }
            return RedirectToAction("viewtMasterStore");

        }

        public ActionResult deleteMasterStore()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            var id = Request["msIDDelete"];
            int mid = Convert.ToInt32(id);
            var a = _inventoryService.getMasterStoreDetails(mid);

            return View(a);
        }

        public ActionResult removeMasterStore()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            var id = Request["msDeleteid"];
            int msid = Convert.ToInt32(id);
            _inventoryService.deleteMasterData(msid);
            return RedirectToAction("viewtMasterStore");
        }


        public ActionResult WareHouseManage()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
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
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }
            return View();
        }

        public JsonResult ViewWareHousedata(DateTime? FromDate = null, DateTime? Todate = null)
        {
            List<WHmanage> WHList = _inventoryService.ViewWareHousedata(FromDate, Todate);
            return Json(WHList,JsonRequestBehavior.AllowGet);        
        }


        public ActionResult SearchSerial()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }

            return View();
        }



        public JsonResult GetSearchSerialDetails (string SerialNumberToSearch) 
        {
            var result = _inventoryService.GetSearchSerialDetails(SerialNumberToSearch);
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        public ActionResult RemainingStock()
        {
            if (Session["LoggedUserID"] == null)
            {
                return RedirectToAction("Login", "Home");
            }

            return View();
        }

        public JsonResult LoadRemainigStock()
        {

            var result = _inventoryService.LoadRemainigStockbyVendor(Convert.ToInt32(Session["LoggedUserID"]));
            return Json(result, JsonRequestBehavior.AllowGet);

        }




    }
}