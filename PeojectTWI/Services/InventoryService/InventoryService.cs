using PeojectTWI.Data;
using PeojectTWI.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace PeojectTWI.Services.InventoryService
{
    public class InventoryService : IInventoryService
    {
        ProjectDBEntities db = new ProjectDBEntities();
        public void insertProductCategory(string brandName, string vendorName, string vendorContact, string vendorEmail, string vendorAddress)
        {
            tblProductCategory tpc = new tblProductCategory();
            tpc.BranchName = brandName;
            tpc.VendorContact = vendorContact;
            tpc.VendorName = vendorName;
            tpc.VendorAddress = vendorAddress;
            tpc.VendorEmail = vendorEmail;
            tpc.CreateDate = DateTime.Now;
            tpc.Active = true;
            db.tblProductCategories.Add(tpc);
            db.SaveChanges();
        }


        public System.Data.Entity.DbSet<tblProductCategory> viewProductCategories( )
        {
            var pdCategories = db.tblProductCategories;
            return (pdCategories);
        }


        public productCategory getProductCategoryDetails(int pid)
        {
            productCategory pd = new productCategory();

            tblProductCategory TPC = db.tblProductCategories.SingleOrDefault(x => x.ProductID == pid);
            pd.ProductID = TPC.ProductID;
            pd.BranchName = TPC.BranchName;
            pd.VendorName = TPC.VendorName;
            pd.VendorContact = TPC.VendorContact;
            pd.VendorAddress = TPC.VendorAddress;
            pd.VendorEmail = TPC.VendorEmail;

            return (pd);
        }

        public async Task updateProductCategory(int productCategoryId, string brandName, string vendorName, string vendorContact, string vendorEmail, string vendorAddress, bool Active)
        {
            var entity = await db.tblProductCategories.FindAsync(productCategoryId);

            if (entity != null)
            {
                entity.BranchName = brandName;
                entity.VendorName = vendorName;
                entity.VendorContact = vendorContact;
                entity.VendorEmail = vendorEmail;
                entity.Active = Active;
                await db.SaveChangesAsync();
            }
            throw new NotImplementedException();
        }

        public async Task deleteProductCategory(int productId)
        {
            var entity = await db.tblProductCategories.FindAsync(productId);
            if (entity != null)
            {
                db.tblProductCategories.Remove(entity);
                db.SaveChanges();
                await db.SaveChangesAsync();
            }

        }

        public void insertMasterStore(int? productId, int? perchesedCount, decimal? unitPrice, DateTime? perchesedDate)
        {
            tblMasterStore tms = new tblMasterStore();
            tms.ProductId = productId;
            tms.perchesedCount = perchesedCount;
            tms.unitPrice = unitPrice;
            tms.PerchesedDate = perchesedDate;
            db.tblMasterStores.Add(tms);
            db.SaveChanges();
        }

        public System.Data.Entity.DbSet<tblMasterStore> viewMasterStore()
        {
            var masterStore = db.tblMasterStores;
            return (masterStore);
        }

        public masterStore getMasterStoreDetails(int mid)
        {
            masterStore ms = new masterStore();

            tblMasterStore tms = db.tblMasterStores.SingleOrDefault(x => x.mStoreId == mid);
            ms.mStoreId = tms.mStoreId;
            ms.ProductId = tms.ProductId;
            ms.perchesedCount = tms.perchesedCount;
            ms.unitPrice = tms.unitPrice;
            ms.PerchesedDate = tms.PerchesedDate;
            return (ms);
        }

        public async Task updateMasterStore(int mStoreId, int? productId, int? perchesedCount, decimal? unitPrice, DateTime? perchesedDate, int? recoredEnterdBy)
        {
            var entity = await db.tblMasterStores.FindAsync(mStoreId);

            if (entity != null)
            {
                entity.ProductId = productId;
                entity.perchesedCount = perchesedCount;
                entity.unitPrice = (decimal?)unitPrice;
                entity.PerchesedDate = perchesedDate;
                entity.perchesedCount = perchesedCount;
                entity.RecoredEnterdBy = recoredEnterdBy;
                await db.SaveChangesAsync();
            }
            throw new NotImplementedException();
        }

        public async Task deleteMasterData(int msID)
        {
            var entity = await db.tblMasterStores.FindAsync(msID);
            if (entity != null)
            {
                db.tblMasterStores.Remove(entity);
                db.SaveChanges();
                await db.SaveChangesAsync();
            }
        }
    }
}