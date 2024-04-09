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

       // void addUser(string username, string firstname, string lastname, string password, int userlevel, int mobilenumber);

        void viewUser(string username);
        int addUser(string userName, string firstName, string lastName,  int? userLevel, string mobileNumber, string email, DateTime? dob);
        Task activateUserAsync(int userId, bool stataus);
        Task updateUser(int userId,string userName, string firstName, string lastName, int? userLevel, string mobileNumber, string email, DateTime? dob);

        Task changeUserStatus(int userId, bool? status);

        List<loggedUser> GetLoggedUsers(string UserName,string Password);
        int checkValidUser(string UserName);
        int loginUser(string UserName, string Password);

        List<Usergroup> getUserlevels();

        List<user> getselectedUserDetails(int UserId);

         string EncryptText(string openText);
         string DecryptText(string encryptedText);

    }
}
