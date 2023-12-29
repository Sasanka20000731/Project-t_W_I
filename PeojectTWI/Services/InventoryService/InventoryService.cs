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
                entity.VendorAddress = vendorAddress;
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

        public List<productCategory> GetProductCategoryValues()
        {

            return (from p in db.tblProductCategories
                   where p.Active == true
                 select new productCategory { 
                     ProductID = p.ProductID,
                     BranchName = p.BranchName}).ToList();


          
        }




        //public List<Branches> GetUnitBranch()
        //{
        //    return (from p in RepositoryFileRecovery.DbEntities.tblBranchUnits
        //            where p.Active == true
        //            select new Branches { Name = p.UnitName, UniqueID = p.tblBranch.LeaseMasterId + "_" + p.Id }).ToList();
        //}

        //public List<Branches> GetRegionBranch(int userID, bool isOneBranch)
        //{
        //    if (isOneBranch == true)
        //    {
        //        var xy = (from q in RepositoryFileRecovery.DbEntities.tblBranches
        //                  join r in RepositoryFileRecovery.DbEntities.tblUsers on q.Id equals r.Branch
        //                  where r.Active == true && q.Active == true && r.Id == userID && q.IsUnit == false
        //                  select new Branches
        //                  {
        //                      Name = q.Branch,
        //                      UniqueID = q.LeaseMasterId + "_0"
        //                  }).ToList();

        //        xy.AddRange((from q in RepositoryFileRecovery.DbEntities.tblBranches
        //                     join r in RepositoryFileRecovery.DbEntities.tblBranchUnits on q.Id equals r.BranchId
        //                     join s in RepositoryFileRecovery.DbEntities.tblUsers on q.Id equals s.Branch
        //                     where s.Active == true && q.Active == true && r.Active == true && s.Id == userID && q.IsUnit == true
        //                     select new Branches
        //                     {
        //                         Name = r.UnitName,
        //                         UniqueID = q.LeaseMasterId + "_" + r.UnitIndex
        //                     }).ToList());
        //        return xy;
        //    }
        //    else
        //    {
        //        var xy = (from p in RepositoryFileRecovery.DbEntities.tblUserAccessibleBranches
        //                  join q in RepositoryFileRecovery.DbEntities.tblBranches on p.BranchId equals q.Id
        //                  where p.Active == true && q.Active == true && p.UserId == userID && q.IsUnit == false
        //                  select new Branches
        //                  {
        //                      Name = q.Branch,
        //                      UniqueID = q.LeaseMasterId + "_0"
        //                  }).ToList();
        //        xy.AddRange((from p in RepositoryFileRecovery.DbEntities.tblUserAccessibleBranches
        //                     join q in RepositoryFileRecovery.DbEntities.tblBranches on p.BranchId equals q.Id
        //                     join r in RepositoryFileRecovery.DbEntities.tblBranchUnits on q.Id equals r.BranchId
        //                     where p.Active == true && q.Active == true && r.Active == true && p.UserId == userID && q.IsUnit == true
        //                     select new Branches
        //                     {
        //                         Name = r.UnitName,
        //                         UniqueID = q.LeaseMasterId + "_" + r.UnitIndex
        //                     }).ToList());
        //        return xy;
        //    }
        //}

        //public List<Region> GetRegionIds(int regionManagerId)
        //{
        //    return (from p in RepositoryFileRecovery.DbEntities.tblBranches
        //            join q in RepositoryFileRecovery.DbEntities.tblUserAccessibleBranches on p.Id equals q.BranchId
        //            where p.Active == true && q.UserId == regionManagerId && p.Region != null
        //            select new Region { RegionId = p.Region.Value }).Distinct().ToList();

        //}

        //public List<UserProfile> GetUserRegistrationDetails(string UserName)
        //{
        //    List<UserProfile> userProfiles = new List<UserProfile>();

        //    using (var context = new FileRecoveryEntities())
        //    {
        //        var dataTable = new DataTable();

        //        using (var cmd = context.Database.Connection.CreateCommand())
        //        {
        //            cmd.CommandText = "spGetEmployerDetails_Registration";
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            cmd.Parameters.Add(new SqlParameter("@@empCode", UserName));


        //            using (var adapter = new SqlDataAdapter((SqlCommand)cmd))
        //            {
        //                adapter.Fill(dataTable);
        //            }
        //        }

        //        foreach (DataRow row in dataTable.Rows)
        //        {
        //            UserProfile details = new UserProfile
        //            {
        //                EmployeeId = row["EmpNo"].ToString(),
        //                FirstName = row["FirstName"].ToString(),
        //                LastName = row["LastName"].ToString(),
        //                BranchName = row["BranchId"].ToString(),
        //                DepartmentName = row["DepartmentId"].ToString(),
        //                Email = row["Email"].ToString(),
        //                UserGroupCode = row["GroupCode"].ToString(),
        //                UserLevelCode = row["LevelCode"].ToString()

        //            };
        //            userProfiles.Add(details);

        //        }

        //        return userProfiles.ToList();

        //    }


        //}
    }
}