using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PeojectTWI.Models;

namespace PeojectTWI.Services.OtherServices
{
    interface IOtherServices
    {
        void InsertAuditTrial(int AuditTrialType, string Description, int CreatedBy);

        List<Dashbord> LoadDashbord(int UserId);
        List<Dashbord> LoadDashbordChart();
    }
}
