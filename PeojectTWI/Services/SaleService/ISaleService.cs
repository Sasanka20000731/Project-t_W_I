using PeojectTWI.Data;
using PeojectTWI.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace PeojectTWI.Services.SaleService
{

    interface ISaleService
    {
        List<saleItem> GetItemDetailsTosale(string SerialNo);

        int saveSaleItem(string cName, string cContact, string cEmail, string cAddress, string SerialNo, decimal Discount, decimal Price, int Warrenty);

        List<saleItem> GetSoldItemData(string SerialNo = null, Nullable<int> InvoiceNo = null, string ContactNo = null);
        List<saleItem> GetSelectedSoldItemData(string SerialNo);
    }
}