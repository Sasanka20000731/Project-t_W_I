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



namespace PeojectTWI.Services.UserService
{
    public class UserService : IUserService
    {
        ProjectDBEntities db = new ProjectDBEntities();
        public void addUser(string userName, string firstName, string lastName, int? userLevel, string mobileNumber, string email, DateTime? dob)
        {
            tblUser tu = new tblUser();
            tu.UserName = userName;
            tu.FirstName = firstName;
            tu.LastName = lastName;
            tu.Password = "123456789";
            tu.UserLevel = userLevel;
            tu.Active = true;
            tu.MobileNumber = mobileNumber;
            tu.Email = email;
            tu.CreatedDate = DateTime.Now;
            tu.DOB = dob;
            db.tblUsers.Add(tu);
            db.SaveChanges();


            throw new NotImplementedException();
        }

        public async Task activateUserAsync(int userId, bool status)
        {

            try
            {
                var entity = await db.tblUsers.FindAsync(userId);

                if (entity != null && status== false)
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

        public void viewUser(string username)
        {
            throw new NotImplementedException();
        }

        public async Task updateUser(int userId,string userName, string firstName, string lastName, int? userLevel, string mobileNumber, string email, DateTime? dob)
        {

            try
            {
                var entity = await db.tblUsers.FindAsync(userId);

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
                    await db.SaveChangesAsync();
                }
              
               
            }
            catch (Exception )
            {
               
            }
      
        }


        public async Task changeUserStatus(int userId, bool? status)
        {
                var entity = await db.tblUsers.FindAsync(userId);
                if (entity != null)
                {
                    entity.Active = status;
                    await db.SaveChangesAsync();
                }
            throw new NotImplementedException();
        }



        public List<loggedUser> GetLoggedUsers(string UserName)
        {
            return (from p in db.tblUsers
                    where p.Active == true && p.UserName == UserName
                    select new loggedUser
                    {
                        UserId = p.UserId,
                        UserLevel = p.UserLevel
                    }).ToList();
        }



    }
}