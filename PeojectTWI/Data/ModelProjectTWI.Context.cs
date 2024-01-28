﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace PeojectTWI.Data
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class ProjectDBEntities : DbContext
    {
        public ProjectDBEntities()
            : base("name=ProjectDBEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<tblCoustomerDetail> tblCoustomerDetails { get; set; }
        public virtual DbSet<tblInventoryData> tblInventoryDatas { get; set; }
        public virtual DbSet<tblInventoryHistory> tblInventoryHistories { get; set; }
        public virtual DbSet<tblMasterStore> tblMasterStores { get; set; }
        public virtual DbSet<tblMasterTicketDetail> tblMasterTicketDetails { get; set; }
        public virtual DbSet<tblMasterWarrenty> tblMasterWarrenties { get; set; }
        public virtual DbSet<tblProductCategory> tblProductCategories { get; set; }
        public virtual DbSet<tblSalesDetail> tblSalesDetails { get; set; }
        public virtual DbSet<tblTicket> tblTickets { get; set; }
        public virtual DbSet<tblTicketComment> tblTicketComments { get; set; }
        public virtual DbSet<tblUser> tblUsers { get; set; }
        public virtual DbSet<tblUserlLevel> tblUserlLevels { get; set; }
        public virtual DbSet<tblWarrentyExtendedDate> tblWarrentyExtendedDates { get; set; }
        public virtual DbSet<tblWarrentyhistory> tblWarrentyhistories { get; set; }
    
        public virtual ObjectResult<sp_ViewAllInventoryData_Result> sp_ViewAllInventoryData(Nullable<System.DateTime> fromDate, Nullable<System.DateTime> toDATE)
        {
            var fromDateParameter = fromDate.HasValue ?
                new ObjectParameter("FromDate", fromDate) :
                new ObjectParameter("FromDate", typeof(System.DateTime));
    
            var toDATEParameter = toDATE.HasValue ?
                new ObjectParameter("ToDATE", toDATE) :
                new ObjectParameter("ToDATE", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_ViewAllInventoryData_Result>("sp_ViewAllInventoryData", fromDateParameter, toDATEParameter);
        }
    }
}
