﻿using PeojectTWI.Data;
using PeojectTWI.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PeojectTWI.Services.InventoryService
{
    interface IInventoryService
    {
        int insertProductCategory( string brandName, string vendorName, string vendorContact, string vendorEmail, string vendorAddress, string productName, int UserId);

        System.Data.Entity.DbSet<tblProductCategory> viewProductCategories();

        List <productCategory> getProductCategoryDetails(int pid);

        Task updateProductCategory(int productCategoryId,string brandName, string vendorName, string vendorContact, string vendorEmail, string vendorAddress, Nullable<bool> Active, string productName);

        Task deleteProductCategory(int productId);

        void insertMasterStore(int? productId, int? perchesedCount, decimal? unitPrice, DateTime? perchesedDate);

        System.Data.Entity.DbSet<tblMasterStore> viewMasterStore();

        masterStore getMasterStoreDetails(int mid);

        Task updateMasterStore(int mStoreId, int? perchesedCount, decimal? unitPrice, DateTime? perchesedDate);

        Task deleteMasterData(int msID);

        List<productCategory> GetProductCategoryValues();

        //List<masterStore> GetmasterStoreValues();

        string CheckExsist(int dataType, int ProductCategory, string SerialNo);
        string ManageWareHouseData(int dataType, int ProductCategory,  string SerialNo);


        List <WHmanage> ViewWareHousedata(DateTime? FromDate,DateTime? Todate);
        List<SerialItem> GetSearchSerialDetails(string SerialNumberToSearch);

        List<WHmanage> LoadRemainigStockbyVendor(int VendorID);

        List<WHmanage> LoadVendorStock(int VendorID);



    }


}
