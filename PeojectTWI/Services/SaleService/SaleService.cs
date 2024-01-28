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

namespace PeojectTWI.Services.SaleService
{
    public class SaleService : ISaleService
    {
        ProjectDBEntities db = new ProjectDBEntities();

        public List<saleItem> GetItemDetailsTosale(string SerialNo)
        {
            var result = (from a in db.tblInventoryDatas
                          join b in db.tblMasterStores on a.MasterId equals b.mStoreId
                          join c in db.tblProductCategories on b.ProductId equals c.ProductID
                          where c.Active == true && a.ToTheStore== true && a.SerialNumber == SerialNo
                          select new saleItem
                          {
                              SerialNumber = a.SerialNumber,
                              unitPrice = b.unitPrice,
                              BrandName = c.BrandName,
                              vendorName = c.VendorName,
                              ProductName = c.ProductName
                          }).ToList();

            return result;
        }

        public int saveSaleItem(string cName, string cContact, string cEmail, string cAddress, string SerialNo, decimal Discount, decimal Price, int Warrenty)
        {


            using (var context = new ProjectDBEntities())
            {
                using (var cmd = context.Database.Connection.CreateCommand())
                {
                    cmd.CommandText = "sp_SaleItem";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@@cName", cName));
                    cmd.Parameters.Add(new SqlParameter("@@cContact", cContact));
                    cmd.Parameters.Add(new SqlParameter("@@cEmail", cEmail));
                    cmd.Parameters.Add(new SqlParameter("@@cAddress", cAddress));
                    cmd.Parameters.Add(new SqlParameter("@@Password", 12345678));
                    cmd.Parameters.Add(new SqlParameter("@@SerialNo", SerialNo));
                    cmd.Parameters.Add(new SqlParameter("@@Discount", Discount));
                    cmd.Parameters.Add(new SqlParameter("@@Price", Price));
                    cmd.Parameters.Add(new SqlParameter("@@Warrenty", Warrenty));

                    context.Database.Connection.Open();
                    var result = cmd.ExecuteScalar();

                    if (result != null && int.TryParse(result.ToString(), out int spResult))
                    {
                        return spResult;
                    }
                    else
                    {
                        return 0;
                    }
                }
            }

           
        }


        public List<saleItem> GetSoldItemData(string SerialNo = null, int? InvoiceNo = null, string ContactNo = null)
        {
            var result = (from a in db.tblInventoryDatas
                          join b in db.tblSalesDetails on a.InventoryID equals b.InventoryId
                          join c in db.tblCoustomerDetails on b.CoustomerId equals c.CoustomerId
                          where (a.SerialNumber == SerialNo) || (b.InvoiceID == InvoiceNo) || (c.ContactNumber == ContactNo)
                          select new
                          {
                              SerialNumber = a.SerialNumber,
                              SoldDate = b.CreatedDate
                          }).ToList()
                          .Select(x => new saleItem
                          {
                              SerialNumber = x.SerialNumber,
                              SoldDate = x.SoldDate.HasValue ? x.SoldDate.Value.ToString() : null
                          }).ToList();

            return result;
        }

        public List<saleItem> GetSelectedSoldItemData(string SerialNo)
        {
            var result = (from a in db.tblInventoryDatas
                          join b in db.tblSalesDetails on a.InventoryID equals b.InventoryId
                          join c in db.tblCoustomerDetails on b.CoustomerId equals c.CoustomerId
                          where (a.SerialNumber == SerialNo)
                          select new
                          {
                              SerialNumber = a.SerialNumber,
                              SoldDate = b.CreatedDate,
                              CustomerName = c.CoustomerName,
                              CustomerContact = c.ContactNumber

                          }).ToList()
                          .Select(x => new saleItem
                          {
                              SerialNumber = x.SerialNumber,
                              SoldDate = x.SoldDate.HasValue ? x.SoldDate.Value.ToString() : null,
                              CoustomerName = x.CustomerName,
                              ContactNumber = x.CustomerContact
                          }).Take(1).ToList();

            return result;
        }

    }
}