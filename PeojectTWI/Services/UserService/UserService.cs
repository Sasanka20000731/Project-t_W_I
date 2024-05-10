using PeojectTWI.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using PeojectTWI.Models;
using System.Data;
using System.Data.SqlClient;
using System.Web.Mvc;
using System.Security.Cryptography;
using System.Text;
using System.IO;

namespace PeojectTWI.Services.UserService
{
    public class UserService : IUserService
    {
        ProjectDBEntities db = new ProjectDBEntities();
          

        public int addUser(string userName, string firstName, string lastName, int? userLevel, string mobileNumber, string email, DateTime? dob)
        {
            try
            {
                tblUser tu = new tblUser();
            tu.UserName = userName;
            tu.FirstName = firstName;
            tu.LastName = lastName;
            tu.Password = "ADX4VeuwJ0BAoXSOXntYdAjr0CMni4/DuqJUOMeJYRY=";
            tu.UserLevel = userLevel;
            tu.Active = true;
            tu.MobileNumber = mobileNumber;
            tu.Email = email;
            tu.CreatedDate = DateTime.Now;
            tu.DOB = dob;
            db.tblUsers.Add(tu);
            db.SaveChanges();
                return 1;
            }
            catch (Exception)
            {
                return 0;
            }

          
        }

        public async Task activateUserAsync(int userId, bool status)
        {

            try
            {
                var entity = await db.tblUsers.FindAsync(userId);

                if (entity != null && status == false)
                {
                    entity.UserId = userId;
                    entity.Active = false;
                    await db.SaveChangesAsync();
                    //  return RedirectToAction("user");
                }
                //ViewBag.Error = "User not found";
                else if (entity != null && status == true)
                {
                    entity.UserId = userId;
                    entity.Active = true;
                    await db.SaveChangesAsync();
                    //  return RedirectToAction("user");
                }

            }
            catch (Exception)
            {
                // ViewBag.Error = "Error updating user: " + ex.Message;
            }

        }


        public int UpdateUser(int userId, string userName, string firstName, string lastName, int? userLevel, string mobileNumber, string email, DateTime? dob, bool active)
        {
            try
            {
                var entity = db.tblUsers.FindAsync(userId).Result;
                if (entity != null)
                {
                    entity.UserName = userName;
                    entity.FirstName = firstName;
                    entity.LastName = lastName;
                    entity.UserLevel = userLevel;
                    entity.MobileNumber = mobileNumber;
                    entity.Email = email;
                    entity.CreatedDate = DateTime.Now;
                    entity.DOB = dob;
                    entity.Active = active;
                    db.SaveChangesAsync().Wait();
                    return 1; // Success
                }
                else
                {
                    return 0; // User not found
                }
            }
            catch (Exception)
            {
                return 0; // Exception occurred
            }
        }


        public List<loggedUser> GetLoggedUsers(string UserName,string Password)
        {
            return (from p in db.tblUsers
                    where p.Active == true && p.UserName == UserName && p.Password == Password
                    select new loggedUser
                    {
                        UserId = p.UserId,
                        UserLevel = p.UserLevel
                    }).ToList();
        }

        public int checkValidUser(string UserName)
        {
            var user = (from p in db.tblUsers
                        where p.Active == true && p.UserName == UserName
                        select new loggedUser
                        {
                            UserId = p.UserId
                        }).FirstOrDefault();

            if (user != null)
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }

        public int loginUser(string UserName,string Password)
        {
            var user = (from p in db.tblUsers
                      where p.Active == true && p.UserName == UserName && p.Password == Password
                      select new loggedUser
                      {
                          UserId = p.UserId
                      }).FirstOrDefault();

            if (user != null )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }


        public List<Usergroup> getUserlevels()
        {
            return  (from a in db.tblUserlLevels
                    where a.Active == true
                    select new Usergroup
                    {
                        userlevelId = a.UserlevelID,
                        UserlevelName = a.UserLevel
                    }).ToList();
        
        }

        public List<user> getselectedUserDetails(int UserId)
        { 
            var result = (from a in db.tblUsers
                          where a.UserId == UserId && a.Active == true
                          select new user
                          {
                              UserName = a.UserName,
                              FirstName = a.FirstName,
                              LastName = a.LastName,
                              UserLevel = a.UserLevel,
                              MobileNumber= a.MobileNumber,
                              Email = a.Email,
                              DOB = a.DOB,
                              Active = a.Active
                             
                          }).ToList();
            return result;
        }

 
        public  string EncryptText(string clearText)
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.Close();
                    }
                    clearText = Convert.ToBase64String(ms.ToArray());
                }
            }
            return clearText;
        }

        public string DecryptText(string cipherText)
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            byte[] cipherBytes = Convert.FromBase64String(cipherText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(cipherBytes, 0, cipherBytes.Length);
                        cs.Close();
                    }
                    cipherText = Encoding.Unicode.GetString(ms.ToArray());
                }
            }
            return cipherText;
        }


        public List<user> loggedUserDetails(int UserId)
        {
            var result = (from a in db.tblUsers 
                          where a.UserId == UserId && a.Active == true
                          select new user
                          {
                              UserName = a.UserName,
                              FirstName = a.FirstName,
                              LastName = a.LastName,
                              UserLevelString = a.tblUserlLevel.UserLevel,
                              MobileNumber = a.MobileNumber,
                              Email = a.Email,
                              DOB = a.DOB,
                              Password = a.Password
                          }).ToList();

            return result;
        }

        public int UpdateUserProfile(int UserID, string FirstName, string LastName)
        {
            try
            {
                var entity = db.tblUsers.FindAsync(UserID).Result;
                if (entity != null)
                {
                    entity.FirstName = FirstName;
                    entity.LastName = LastName;

                    db.SaveChangesAsync().Wait();
                    return 1;
                }
                else
                {
                    return 0;
                }
            }
            catch (Exception)
            {
                return 0;
            }


        }

    }
}