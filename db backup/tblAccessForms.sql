USE [ProjectDB]
GO
/****** Object:  Table [dbo].[tblAccessForms]    Script Date: 15/05/2024 22:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAccessForms](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ControllerName] [nvarchar](max) NULL,
	[ActionName] [nvarchar](max) NULL,
	[ShowingName] [nvarchar](max) NULL,
	[MenuCategory] [nvarchar](max) NULL,
	[UserLevel] [int] NULL,
 CONSTRAINT [PK_tblAccessForms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblAccessForms] ON  
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (1, N'Home', N'addUser', N'Add User', N'User Management', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (2, N'Home', N'viewUser', N'View User', N'User Management', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (3, N'Inventory', N'insertProductCategory', N'Add Product Category', N'Inventory Management', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (4, N'Inventory', N'viewProductCategories', N'View Product Category', N'Inventory Management', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (5, N'Inventory', N'insertMasterStore', N'Add Master Store Items', N'Inventory Management', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (6, N'Inventory', N'viewtMasterStore', N'View Master Store', N'Inventory Management', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (7, N'Inventory', N'WarehouseManage', N'Warehouse Manage', N'Inventory Management', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (8, N'Inventory', N'ViewWareHouse', N'View Full WareHouse', N'Inventory Management', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (9, N'Inventory', N'SearchSerial', N'Search In WareHouse', N'Inventory Management', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (10, N'Sale', N'SaleItem', N'Sale Item', N'Sale Management', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (11, N'Sale', N'RejectSaleItem', N'Reject Sale Item', N'Sale Management', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (12, N'Warrenty', N'CheckWarrenty', N'Check Warrenty Detail', N'Warrenty Management', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (13, N'Ticket', N'AddTicket', N'Add Ticket', N'Ticket Managemt', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (14, N'Ticket', N'AssignTicket', N'Assign Tickets', N'Ticket Managemt', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (15, N'Ticket', N'ManageTicket', N'Manage Tickets', N'Ticket Managemt', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (16, N'Ticket', N'TicketSearch', N'Search Tickets', N'Ticket Managemt', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (17, N'Report', N'UserManagementReportForm', N'User Managemet Report', N'Reports', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (18, N'Report', N'InventoryManagementReportForm', N'Inventory Management Report', N'Reports', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (19, N'Report', N'TicketManagementReportForm', N'Ticket Management Report', N'Reports', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (20, N'Report', N'WarrentyManagementReportForm', N'Warrenty Management Report', N'Reports', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (21, N'Home', N'ContactUs', N'Contact From Email', N'Contact US', 1)
GO
INSERT [dbo].[tblAccessForms] ([Id], [ControllerName], [ActionName], [ShowingName], [MenuCategory], [UserLevel]) VALUES (22, N'Home', N'ViewAudiTrail', N'Audit Trail Details', N'Audit Trail', 1)
GO
SET IDENTITY_INSERT [dbo].[tblAccessForms] OFF
GO
