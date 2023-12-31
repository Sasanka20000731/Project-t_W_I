using PeojectTWI.Data;
using PeojectTWI.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PeojectTWI.Services.InventoryService
{
    interface IInventoryService
    {
        void insertProductCategory( string brandName, string vendorName, string vendorContact, string vendorEmail, string vendorAddress);

        System.Data.Entity.DbSet<tblProductCategory> viewProductCategories();

        productCategory getProductCategoryDetails(int pid);

        Task updateProductCategory(int productCategoryId,string brandName, string vendorName, string vendorContact, string vendorEmail, string vendorAddress, bool Active);

        Task deleteProductCategory(int productId);

        void insertMasterStore(int? productId, int? perchesedCount, decimal? unitPrice, DateTime? perchesedDate);

        System.Data.Entity.DbSet<tblMasterStore> viewMasterStore();

        masterStore getMasterStoreDetails(int mid);

        Task updateMasterStore(int mStoreId, int? productId, int? perchesedCount, decimal? unitPrice, DateTime? perchesedDate, int? recoredEnterdBy);

        Task deleteMasterData(int msID);

        List<productCategory> GetProductCategoryValues();

        List<masterStore> GetmasterStoreValues();

        bool ManageWareHouseData(int dataType, int ProductCategory, int MasterStore, string SerialNo);
        List <WHmanage> ViewWareHousedata(DateTime? FromDate,DateTime? Todate);

    }


}
