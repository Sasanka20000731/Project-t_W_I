using PeojectTWI.Data;
using PeojectTWI.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace PeojectTWI.Services.WarrentyService
{
    public class WarrentyService : IWarrentyService
    {
        ProjectDBEntities db = new ProjectDBEntities();
         public List<Warrenty> GetWarrentyComments(string SerialNumber) {
            var result = (from a in db.tblInventoryDatas
                          join b in db.tblMasterWarrenties on a.InventoryID equals b.inventoryId
                          join c in db.tblWarrentyhistories on b.mWarrentyId equals c.mWarrentyId
                          join d in db.tblSalesDetails on a.InventoryID equals d.InventoryId
                          where (a.SerialNumber == SerialNumber) 
                          select new Warrenty
                          {
                              WarrentyStartDate = b.WarrentyStartDate.ToString(),
                              WarrentyExpiredDate = b.WarrentyExpierdDate.ToString(),
                              WarrentyComments = c.comment,
                              WarrentyCommentedDate = c.createdDate.ToString(),
                              SoldPrice = d.SoldPrice
                          }).ToList();
            return result;
        }

        public List<Warrenty> GetWarrentyList(string ContactNumber)
        {
            var result = (from a in db.tblCoustomerDetails
                          join b in db.tblSalesDetails on a.CoustomerId equals b.CoustomerId
                          join c in db.tblMasterWarrenties on b.InventoryId equals c.inventoryId
                          join d in db.tblInventoryDatas on c.inventoryId equals d.InventoryID
                          where (a.ContactNumber == ContactNumber)
                          select new Warrenty
                          {
                              SerialNo = d.SerialNumber,
                              WarrentyStatus = (DateTime.Now > c.WarrentyExpierdDate)
                                                 ? "Expired"
                                                 : "Not Expired"
                          }).ToList();
            return result;
        }

        public int SaveExtenWarrenty(string SerialNumber, decimal ExtendCost)
        {

            //Implement Sp
            // tblmwarrebty, warrentyHostory , sale , warrentyexten
            return 0;
        
        }

    }
}

