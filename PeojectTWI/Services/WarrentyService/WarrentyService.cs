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
                          where (a.SerialNumber == SerialNumber) 

                          select new Warrenty
                          {
                              WarrentyStartDate = b.WarrentyStartDate.ToString(),
                              WarrentyExpiredDate = b.WarrentyExpierdDate.ToString(),
                              WarrentyComments = c.comment,
                              WarrentyCommentedDate = c.createdDate.ToString()
                          }).Distinct().ToList();

            decimal? bb = (from a in db.tblInventoryDatas
                      join b in db.tblMasterWarrenties on a.InventoryID equals b.inventoryId
                      join c in db.tblWarrentyhistories on b.mWarrentyId equals c.mWarrentyId
                      join d in db.tblSalesDetails on a.InventoryID equals d.InventoryId
                      where (a.SerialNumber == SerialNumber)
                      select d.SoldPrice).FirstOrDefault();

            foreach (var item in result) 
            {
                item.SoldPrice = bb;
            }


            return result;
        }

        public List<Warrenty> GetWarrentyList(string ContactNumber)
        {
            //update edmx. add cell to tblsale ExtendPrice Decimal(18,2)
            var result = (from a in db.tblCoustomerDetails
                          join b in db.tblSalesDetails on a.CoustomerId equals b.CoustomerId
                          join c in db.tblMasterWarrenties on b.InventoryId equals c.inventoryId
                          join d in db.tblInventoryDatas on c.inventoryId equals d.InventoryID
                          where (a.ContactNumber == ContactNumber && b.ExtendPrice == null)
                          select new Warrenty
                          {
                              SerialNo = d.SerialNumber,
                              WarrentyStatus =  (DateTime.Now > c.WarrentyExpierdDate)
                                                 ? "Expired"
                                                 : "Not Expired"

                          }).ToList();
            return result;
        }

        public int SaveExtenWarrenty(string SerialNumber,int WarrentyMonths, decimal ExtendCost)
        {

            using (var context = new ProjectDBEntities())
            {
                using (var cmd = context.Database.Connection.CreateCommand())
                {
                    cmd.CommandText = "sp_ExtendWarrenty";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@@SerialNumber", SerialNumber));
                    cmd.Parameters.Add(new SqlParameter("@@WarrentyMonths", WarrentyMonths));
                    cmd.Parameters.Add(new SqlParameter("@@ExtendCost", ExtendCost));

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

    }
}

