using PeojectTWI.Data;
using PeojectTWI.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace PeojectTWI.Services.InventoryService
{
    public class InventoryService : IInventoryService
    {
        ProjectDBEntities db = new ProjectDBEntities();
        public int insertProductCategory(string brandName, string vendorName, string vendorContact, string vendorEmail, string vendorAddress, string productName, int UserId)
        {
            try
            {
                tblProductCategory tpc = new tblProductCategory();
                tpc.BrandName = brandName;
                tpc.VendorContact = vendorContact;
                tpc.VendorName = vendorName;
                tpc.VendorAddress = vendorAddress;
                tpc.VendorEmail = vendorEmail;
                tpc.ProductName = productName;
                tpc.CreateDate = DateTime.Now;
                tpc.Active = true;
                tpc.UserID = UserId;
                db.tblProductCategories.Add(tpc);
                db.SaveChanges();
                return 1;
            }
            catch {
                return 0;
            }

        }


        public System.Data.Entity.DbSet<tblProductCategory> viewProductCategories( )
        {
            var pdCategories = db.tblProductCategories;
            return (pdCategories);
        }


        public List <productCategory> getProductCategoryDetails(int pid)
        {
           var result = (from a in  db.tblProductCategories 
                         where a.ProductID == pid
                select new productCategory
                {
                    ProductID = a.ProductID,
                    BrandName = a.BrandName,
                    VendorName = a.VendorName,
                    VendorContact = a.VendorContact,
                    VendorAddress = a.VendorAddress,
                    VendorEmail = a.VendorEmail,
                    ProductName = a.ProductName,
                    Active = a.Active

                }).ToList();

            return result;
        }

        public async Task updateProductCategory(int productCategoryId, string brandName, string vendorName, string vendorContact, string vendorEmail, string vendorAddress, Nullable<bool> Active, string productName)
        {
            var entity = await db.tblProductCategories.FindAsync(productCategoryId);

            if (entity != null)
            {
                entity.BrandName = brandName;
                entity.VendorName = vendorName;
                entity.VendorContact = vendorContact;
                entity.VendorEmail = vendorEmail;
                entity.VendorAddress = vendorAddress;
                entity.ProductName = productName;
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
                entity.Active = false;
               // db.tblProductCategories.Remove(entity);
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
            tms.createdDate = DateTime.Now;
            var ss = HttpContext.Current.Session["LoggedUseriD"];
            tms.RecoredEnterdBy =  Convert.ToInt32(ss);
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


            ms.PerchesedDateString= Convert.ToDateTime(tms.PerchesedDate).ToString("dd/MM/yyyy");             //.ToString("dd/MM/yyyy");
            ms.PerchesedDate = tms.PerchesedDate;

            ms.RecoredEnterdBy = tms.RecoredEnterdBy;
            ms.createdDate = tms.createdDate;

            return (ms);
        }

        public async Task updateMasterStore(int mStoreId,  int? perchesedCount, decimal? unitPrice, DateTime? perchesedDate)
        {
            var entity = await db.tblMasterStores.FindAsync(mStoreId);

            if (entity != null)
            {
                //entity.ProductId = productId;
                entity.perchesedCount = perchesedCount;
                entity.unitPrice = (decimal?)unitPrice;
                entity.PerchesedDate = perchesedDate;
               // entity.RecoredEnterdBy = recoredEnterdBy;

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
            var result = (from a in db.tblProductCategories
                          join b in db.tblMasterStores on a.ProductID equals b.ProductId
                          where a.Active == true
                          select new productCategory
                          {
                              ProductID = a.ProductID,
                              ProductName = a.ProductName+" ("+a.BrandName+") "+ b.PerchesedDate
                          }).ToList();
            return result;
        }

        //public List<productCategory> GetProductCategoryValues()
        //{
        //    return (from p in db.tblProductCategories
        //           where p.Active == true
        //         select new productCategory { 
        //             ProductID = p.ProductID,
        //             ProductName = p.ProductName}).ToList();
        //}


        //public List<masterStore> GetmasterStoreValues()
        //{
        //    return (from p in db.tblProductCategories join
        //            q in db.tblMasterStores on p.ProductID equals q.ProductId
        //            select new masterStore
        //            {
        //                mStoreId = q.mStoreId,
        //                MasterProductName = p.BrandName
        //            }).ToList();
        //}

        public string ManageWareHouseData(int dataType, int ProductCategory, string SerialNo)
        {
            using (var context = new ProjectDBEntities())
            {
                using (var command = context.Database.Connection.CreateCommand())
                {
                    command.CommandText = "exec [sp_ManageWareHouse] @DataType, @ProductCategory, @SerialNo";
                    command.Parameters.Add(new SqlParameter("@DataType", dataType));
                    command.Parameters.Add(new SqlParameter("@ProductCategory", ProductCategory));
                    command.Parameters.Add(new SqlParameter("@SerialNo", SerialNo));

                    context.Database.Connection.Open();

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return reader["RESULT"].ToString();
                        }
                    }
                }
            }

            return null; 
        }

        public List<WHmanage> ViewWareHousedata(DateTime? FromDate, DateTime? Todate)
        {
            List<WHmanage> whmanageList = new List<WHmanage>();

            using (var context = new ProjectDBEntities())
            {
                var DataTable1 = new DataTable();

                using (var command = context.Database.Connection.CreateCommand())
                {
                    command.CommandText = "exec [sp_ViewAllInventoryData] @FromDate, @ToDATE";
                    command.Parameters.Add(new SqlParameter("@FromDate", (object)FromDate ?? DBNull.Value));
                    command.Parameters.Add(new SqlParameter("@ToDATE", (object)Todate ?? DBNull.Value));

                    context.Database.Connection.Open();

                    using (var reader = command.ExecuteReader())
                    {
                        DataTable1.Load(reader);
                    }
                }

                foreach (DataRow row in DataTable1.Rows)
                {
                    WHmanage wHmanage = new WHmanage
                    {
                        BrandName = row["BrandName"].ToString(),
                        VendorName = row["VendorName"].ToString(),
                        VendorContact = row["VendorContact"].ToString(),
                        VendorEmail = row["VendorEmail"].ToString(),
                        PerchesedCount = Convert.ToInt32(row["PerchesedCount"]),
                        UnitPrice = Convert.ToDecimal(row["UnitPrice"]),
                        TotalCost = Convert.ToDecimal(row["TotalCost"]),
                        InSaleInventory = Convert.ToInt32(row["InSaleInventory"]),
                        NotInAnyStore = Convert.ToInt32(row["NotInAnyStore"]),
                        RemainingCount = Convert.ToInt32(row["RemainingCount"]),
                        ProductName  = row["ProductName"].ToString()
                    };

                    whmanageList.Add(wHmanage);
                }
            }

            return whmanageList.ToList();
        }

        public string CheckExsist(int dataType, int productCategory, string serialNo)
        {
            string resultMessage = "";

            if (dataType == 1)
            {
                var result = (from a in db.tblInventoryDatas
                              where (a.ProductCategoryId == productCategory && a.SerialNumber == serialNo && a.ToTheStore == true)
                              select a).FirstOrDefault();

                resultMessage = result != null ? "Already in the store" : "";
            }
            else if (dataType == 2)
            {
                var result = (from a in db.tblInventoryDatas
                              where (a.ProductCategoryId == productCategory && a.SerialNumber == serialNo && a.ToTheOutside == true)
                              select a).FirstOrDefault();

                resultMessage = result != null ? "Already not in the store" : "";
            }
            else
            {
                throw new NotImplementedException();
            }

            return resultMessage;
        }


        public List<SerialItem> GetSearchSerialDetails(string SerialNumberToSearch)
        {
            var result = (from a in db.tblInventoryDatas 
                          join b in db.tblProductCategories on a.ProductCategoryId equals b.ProductID
                        //  join c in db.tblMasterStores on a.MasterId equals c.mStoreId
                          where a.SerialNumber == SerialNumberToSearch
                          select new SerialItem
                          { 
                            BrandName = b.BrandName,
                            ProductName = b.ProductName,
                            VendorName = b.VendorName,
                            VendorEmail = b.VendorEmail,
                            VendorContact = b.VendorContact,
                            InOrOutDateStr = (a.ToTheStore == true ? a.InsertedDate.ToString() : a.OutedDateFromStore.ToString()),
                            //OutToTheStoreDateStr = a.OutedDateFromStore.ToString(),
                            CurrentLocation = (a.ToTheStore == true ? "In Store" : "Not In the Store")

                          }).ToList();



            return result;

        }

        public List<WHmanage> LoadRemainigStockbyVendor(int VendorID)
        {

            var result = (from a in db.tblProductCategories
                          where a.UserID == VendorID
                          select new WHmanage
                          {
                              BrandName = a.BrandName,
                              ProductName = a.ProductName,
                              VendorName = a.VendorName,
                              VendorContact = a.VendorContact,
                              VendorAddress = a.VendorAddress,
                              CreatedDate = a.CreateDate
                          }).ToList();

            return result;

        }


        public int LoadVendorStock(int VendorID)
        {

            var sql = "SELECT A.BrandName,A.ProductName, A.VendorName, A.VendorContact, A.VendorEmail,B.perchesedCount,B.unitPrice, (b.perchesedCount * b.unitPrice),(select count(ToTheStore) from tblInventoryData where ToTheStore = 1 and ProductCategoryId = a.ProductID and MasterId = b.mStoreId ), (select count(ToTheOutside) from tblInventoryData where ToTheOutside = 1 and ProductCategoryId = a.ProductID and MasterId = b.mStoreId ), (B.perchesedCount - ((select COUNT(ToTheOutside) from tblInventoryData where ToTheOutside = 1 AND ProductCategoryId = a.ProductID and MasterId = b.mStoreId)+(select COUNT(ToTheStore) from tblInventoryData where ToTheStore = 1 and ProductCategoryId = a.ProductID and MasterId = b.mStoreId))) FROM tblProductCategories A LEFT JOIN tblMasterStore B ON A.ProductID = B.ProductId  LEFT JOIN tblInventoryData C ON B.mStoreId = C.MasterId And B.ProductId = A.ProductID WHERE A.ProductID = 2013";
   

            using (var context = new ProjectDBEntities())
            {
                var DataTable1 = new DataTable();

                using (var command = context.Database.Connection.CreateCommand())
                {
                    command.CommandText = sql;
  
                    context.Database.Connection.Open();

                    using (var reader = command.ExecuteReader())
                    {
                        DataTable1.Load(reader);
                    }
                }

                
            }

            return 1;


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