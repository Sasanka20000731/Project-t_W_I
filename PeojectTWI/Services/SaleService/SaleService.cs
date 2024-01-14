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
                          where c.Active == true && a.SerialNumber == SerialNo
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

        public int saveSaleItem(string cName, string cContact, string cEmail, string cAddress, string cbackUpccontact, string SerialNo, decimal Discount, decimal Price, int Warrenty)
        {



            throw new NotImplementedException();
        }
    }
}