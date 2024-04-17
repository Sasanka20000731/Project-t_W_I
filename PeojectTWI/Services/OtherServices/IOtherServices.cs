using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PeojectTWI.Services.OtherServices
{
    interface IOtherServices
    {
        void InsertAuditTrial(int AuditTrialType, string Description, int CreatedBy);

    }
}
