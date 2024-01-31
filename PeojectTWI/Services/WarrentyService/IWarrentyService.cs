using PeojectTWI.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PeojectTWI.Services.WarrentyService
{
    interface IWarrentyService
    {
        List<Warrenty> GetWarrentyComments(string SerialNumber);

        List<Warrenty> GetWarrentyList(string ContactNumber);

        int SaveExtenWarrenty(string SerialNumber, decimal ExtendCost);

    }
}
