using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PeojectTWI.Models
{
    public class user
    {

        public int UserId { get; set; }
        public string UserName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public Nullable<System.DateTime> DOB { get; set; }
        public string Email { get; set; }
        public string MobileNumber { get; set; }
        public Nullable<int> UserLevel { get; set; }
        public Nullable<bool> Active { get; set; }
        public string Password { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }

        public Usergroup usergroup { get; set; }
 

    }

    public class Usergroup 
    {
        public int userlevelId { get; set; }

        public string UserlevelName { get; set; }
    }
}