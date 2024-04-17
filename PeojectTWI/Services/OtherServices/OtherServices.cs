using PeojectTWI.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace PeojectTWI.Services.OtherServices
{
    public class OtherServices : IOtherServices
    {
        public void InsertAuditTrial(int AuditTrialType, string Description, int CreatedBy)
        {
            //-----------------un comment this function
            using (var context = new ProjectDBEntities())
            {
                using (var cmd = context.Database.Connection.CreateCommand())
                {
                    cmd.CommandText = "sp_AuditTrial";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@@AuditTrialType", AuditTrialType));
                    cmd.Parameters.Add(new SqlParameter("@@Description", Description));
                    cmd.Parameters.Add(new SqlParameter("@@CreatedBy", CreatedBy));
                    context.Database.Connection.Open();
                    var result = cmd.ExecuteScalar();
                }
            }
        }
    }
}