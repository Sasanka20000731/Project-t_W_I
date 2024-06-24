USE [ProjectDB]
GO
/****** Object:  Table [dbo].[tblProductCategories]    Script Date: 6/17/2024 4:34:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProductCategories](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[BrandName] [nvarchar](100) NULL,
	[VendorName] [nvarchar](100) NULL,
	[VendorContact] [nchar](13) NULL,
	[VendorAddress] [nvarchar](200) NULL,
	[VendorEmail] [nvarchar](100) NULL,
	[CreateDate] [datetime] NULL,
	[Active] [bit] NULL,
	[ProductName] [nvarchar](100) NULL,
	[UserID] [int] NULL, 
 CONSTRAINT [PK_tblProductCategories] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblProductCategories] ON 
GO
INSERT [dbo].[tblProductCategories] ([ProductID], [BrandName], [VendorName], [VendorContact], [VendorAddress], [VendorEmail], [CreateDate], [Active], [ProductName], [UserID]) VALUES (4, N'abanse', N'SInhagiri', N'0761554894   ', N'No 15, Maharagama Rd, Colombo', N'sinhagirimaharagama@gmail.com', CAST(N'2023-11-11T15:48:33.850' AS DateTime), 1, N'Abanse Laptop', NULL)
GO
INSERT [dbo].[tblProductCategories] ([ProductID], [BrandName], [VendorName], [VendorContact], [VendorAddress], [VendorEmail], [CreateDate], [Active], [ProductName], [UserID]) VALUES (5, N'Asus', N'Singar', N'0751234567   ', N'No 15, Maharagama Rd, Colombo', N'singar@gmail.com', CAST(N'2023-11-23T00:00:00.000' AS DateTime), 1, N'Asus VivoBook', NULL)
GO
INSERT [dbo].[tblProductCategories] ([ProductID], [BrandName], [VendorName], [VendorContact], [VendorAddress], [VendorEmail], [CreateDate], [Active], [ProductName], [UserID]) VALUES (6, N'Asus', N'lb', N'045127454    ', N'No 15, Maharagama Rd, Colombo 10', N'ausumaharagama@gmail.com', CAST(N'2024-01-03T11:58:18.527' AS DateTime), 1, N'Mouse', NULL)
GO
INSERT [dbo].[tblProductCategories] ([ProductID], [BrandName], [VendorName], [VendorContact], [VendorAddress], [VendorEmail], [CreateDate], [Active], [ProductName], [UserID]) VALUES (1010, N'Samsung Node Pad', N'softlogic', N'0754565126   ', N'454/1  kollupitiya Road, Dehiwala', N'softlogicdehiwala@gamail.com', CAST(N'2024-04-08T21:28:14.567' AS DateTime), 1, N'Samsung', NULL)
GO
INSERT [dbo].[tblProductCategories] ([ProductID], [BrandName], [VendorName], [VendorContact], [VendorAddress], [VendorEmail], [CreateDate], [Active], [ProductName], [UserID]) VALUES (1011, N'dddddddd', N'ssssssssssssssss', N'0754596512   ', N'56/c Dehiwala Rd, Dehiwala', N'nanotech@gmail.com', CAST(N'2024-04-12T23:19:38.113' AS DateTime), 0, N'ssss', NULL)
GO
INSERT [dbo].[tblProductCategories] ([ProductID], [BrandName], [VendorName], [VendorContact], [VendorAddress], [VendorEmail], [CreateDate], [Active], [ProductName], [UserID]) VALUES (1012, N'Legion 5', N'finco', N'0756321459   ', N'No 15, Maharagama Rd, Colombo 10', N'nanotech@gmail.com', CAST(N'2024-04-12T23:23:42.930' AS DateTime), 1, N'Lenovo', NULL)
GO
INSERT [dbo].[tblProductCategories] ([ProductID], [BrandName], [VendorName], [VendorContact], [VendorAddress], [VendorEmail], [CreateDate], [Active], [ProductName], [UserID]) VALUES (1013, N'test audit trial product', N'test audit trial product', N'0457884155   ', N'asdasfasf af afa sfaf', N'sdasdadad@gmail.com', CAST(N'2024-04-18T08:47:24.110' AS DateTime), 1, N'test audit trial product category', NULL)
GO
INSERT [dbo].[tblProductCategories] ([ProductID], [BrandName], [VendorName], [VendorContact], [VendorAddress], [VendorEmail], [CreateDate], [Active], [ProductName], [UserID]) VALUES (2013, N'sdadasd', N'adasd', N'0761554894   ', N'No 15, Maharagama Rd, Colombo', N'sinhagirimaharagama@gmail.com', CAST(N'2024-06-17T10:04:20.330' AS DateTime), 1, N'eeeee', 16)
GO
SET IDENTITY_INSERT [dbo].[tblProductCategories] OFF
GO
ALTER TABLE [dbo].[tblProductCategories]  WITH CHECK ADD  CONSTRAINT [FK_tblProductCategories_tblUser] FOREIGN KEY([UserID])
REFERENCES [dbo].[tblUser] ([UserId])
GO
ALTER TABLE [dbo].[tblProductCategories] CHECK CONSTRAINT [FK_tblProductCategories_tblUser]
GO
