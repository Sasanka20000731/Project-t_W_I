using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PeojectTWI.Models;

namespace PeojectTWI.Services.UserService
{
    interface IUserService
    {
        int addUser(string userName, string firstName, string lastName,  int? userLevel, string mobileNumber, string email, DateTime? dob);
        Task activateUserAsync(int userId, bool stataus);
        int UpdateUser(int userId,string userName, string firstName, string lastName, int? userLevel, string mobileNumber, string email, DateTime? dob, bool Active);
        List<loggedUser> GetLoggedUsers(string UserName,string Password);
        int checkValidUser(string UserName);
        int loginUser(string UserName, string Password);
        List<Usergroup> getUserlevels();
        List<user> getselectedUserDetails(int UserId);
        string EncryptText(string openText);
        string DecryptText(string encryptedText);

        List<user> loggedUserDetails(int UserId);
        int UpdateUserProfile(int UserID, string FirstName, string LastName);
        List<AccessForm> loadAccessForms(int loggedUser);
        int getVendorID(string VendorName);
        int getCustomerID(string Customer);

        List<PieChartModel> LoadPieChartData();

        int ResetPassword(string emailAddress);
        int CheckCurrentPassword(string enteredCurrentPassword, int loggeduser);
        int UpdateUserPassword(string enteredNewPassword, int loggeduser);

    }
}
