using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PeojectTWI.Models
{
    public class StaticManageClass
    {

        public static IList<AccessForm> PermissionForm
        {
            get
            {
                if (HttpContext.Current.Session["AccessForm"] == null)
                    return null;

                return HttpContext.Current.Session["AccessForm"] as List<AccessForm>;
            }
            set { HttpContext.Current.Session["AccessForm"] = value; }
        }

    }
}