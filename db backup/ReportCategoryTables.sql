USE [ProjectDB]
GO
/****** Object:  Table [dbo].[tblReportCategory]    Script Date: 20/03/2024 08:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblReportCategory](
	[ReportCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[ReportCategoryName] [nvarchar](50) NULL,
	[Active] [bit] NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_tblReportCategory] PRIMARY KEY CLUSTERED 
(
	[ReportCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblReportType]    Script Date: 20/03/2024 08:35:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblReportType](
	[ReportTypeID] [int] IDENTITY(1,1) NOT NULL, 
	[ReportCategoryId] [int] NULL,
	[ReportTypeValue] [int] NULL,
	[ReportTypeName] [nvarchar](50) NULL,
	[Active] [bit] NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_tblReportType] PRIMARY KEY CLUSTERED 
(
	[ReportTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblReportCategory] ON 
GO
INSERT [dbo].[tblReportCategory] ([ReportCategoryId], [ReportCategoryName], [Active], [CreateDate]) VALUES (1, N'User Management Report', 1, CAST(N'2024-03-19T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[tblReportCategory] ([ReportCategoryId], [ReportCategoryName], [Active], [CreateDate]) VALUES (2, N'Inventory Management Report', 1, CAST(N'2024-03-19T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[tblReportCategory] ([ReportCategoryId], [ReportCategoryName], [Active], [CreateDate]) VALUES (3, N'Ticket Management Report', 1, CAST(N'2024-03-19T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[tblReportCategory] ([ReportCategoryId], [ReportCategoryName], [Active], [CreateDate]) VALUES (4, N'Other Report', 1, CAST(N'2024-03-19T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[tblReportCategory] ([ReportCategoryId], [ReportCategoryName], [Active], [CreateDate]) VALUES (5, N'Audit Trial Report', 1, CAST(N'2024-03-19T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tblReportCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[tblReportType] ON 
GO
INSERT [dbo].[tblReportType] ([ReportTypeID], [ReportCategoryId], [ReportTypeValue], [ReportTypeName], [Active], [CreateDate]) VALUES (1, 1, 1, N'All', 1, CAST(N'2024-03-19T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[tblReportType] ([ReportTypeID], [ReportCategoryId], [ReportTypeValue], [ReportTypeName], [Active], [CreateDate]) VALUES (2, 1, 2, N'Customers', 1, CAST(N'2024-03-19T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[tblReportType] ([ReportTypeID], [ReportCategoryId], [ReportTypeValue], [ReportTypeName], [Active], [CreateDate]) VALUES (3, 1, 3, N'Vendors', 1, CAST(N'2024-03-19T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tblReportType] OFF
GO
ALTER TABLE [dbo].[tblReportType]  WITH CHECK ADD  CONSTRAINT [FK_tblReportType_tblReportCategory] FOREIGN KEY([ReportCategoryId])
REFERENCES [dbo].[tblReportCategory] ([ReportCategoryId])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tblReportType] CHECK CONSTRAINT [FK_tblReportType_tblReportCategory]
GO
