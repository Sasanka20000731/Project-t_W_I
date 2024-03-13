USE [master]
GO
/****** Object:  Database [ProjectDB]    Script Date: 13/03/2024 10:54:03 ******/
CREATE DATABASE [ProjectDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ProjectDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ProjectDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ProjectDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ProjectDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ProjectDB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ProjectDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ProjectDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ProjectDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ProjectDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ProjectDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ProjectDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ProjectDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ProjectDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ProjectDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ProjectDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ProjectDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ProjectDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ProjectDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ProjectDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ProjectDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ProjectDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ProjectDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ProjectDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ProjectDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ProjectDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ProjectDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ProjectDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ProjectDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ProjectDB] SET RECOVERY FULL 
GO
ALTER DATABASE [ProjectDB] SET  MULTI_USER 
GO
ALTER DATABASE [ProjectDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ProjectDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ProjectDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ProjectDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ProjectDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ProjectDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ProjectDB', N'ON'
GO
ALTER DATABASE [ProjectDB] SET QUERY_STORE = OFF
GO
USE [ProjectDB]
GO
/****** Object:  Table [dbo].[tblCoustomerDetails]    Script Date: 13/03/2024 10:54:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCoustomerDetails](
	[CoustomerId] [int] IDENTITY(1,1) NOT NULL,
	[CoustomerName] [nvarchar](max) NULL,
	[Address] [nvarchar](300) NULL,
	[Email] [nvarchar](80) NULL,
	[ContactNumber] [nchar](13) NULL,
	[UserName] [nvarchar](10) NULL,
	[Password] [nvarchar](max) NULL,
	[Active] [bit] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_tblCoustomerDetails] PRIMARY KEY CLUSTERED 
(
	[CoustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblInventoryData]    Script Date: 13/03/2024 10:54:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblInventoryData](
	[InventoryID] [int] IDENTITY(1,1) NOT NULL,
	[ProductCategoryId] [int] NULL,
	[MasterId] [int] NULL,
	[SerialNumber] [nvarchar](150) NULL,
	[ToTheStore] [bit] NULL,
	[InsertedDate] [datetime] NULL,
	[ToTheOutside] [bit] NULL,
	[OutedDateFromStore] [datetime] NULL,
 CONSTRAINT [PK_tblInventoryData] PRIMARY KEY CLUSTERED 
(
	[InventoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblInventoryHistory]    Script Date: 13/03/2024 10:54:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblInventoryHistory](
	[inventoryHistoryId] [int] IDENTITY(1,1) NOT NULL,
	[inventoryId] [int] NULL,
	[Remark] [nvarchar](max) NULL,
	[createDate] [datetime] NULL,
	[createdby] [int] NULL,
 CONSTRAINT [PK_tblInventoryHistory] PRIMARY KEY CLUSTERED 
(
	[inventoryHistoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblMasterStore]    Script Date: 13/03/2024 10:54:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMasterStore](
	[mStoreId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[perchesedCount] [int] NULL,
	[unitPrice] [decimal](18, 0) NULL,
	[PerchesedDate] [datetime] NULL,
	[RecoredEnterdBy] [int] NULL,
	[createdDate] [datetime] NULL,
 CONSTRAINT [PK_tblMasterStore] PRIMARY KEY CLUSTERED 
(
	[mStoreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblMasterTicketDetails]    Script Date: 13/03/2024 10:54:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMasterTicketDetails](
	[mTicketID] [int] IDENTITY(1,1) NOT NULL,
	[TicketID] [int] NULL,
	[isAssigned] [bit] NULL,
	[AssignedDate] [datetime] NULL,
	[AssignedTo] [int] NULL,
	[IsAccepted] [bit] NULL,
 CONSTRAINT [PK_tblMasterTicketDetails] PRIMARY KEY CLUSTERED 
(
	[mTicketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblMasterTicketSequnces]    Script Date: 13/03/2024 10:54:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMasterTicketSequnces](
	[SequanceIndexID] [int] IDENTITY(1,1) NOT NULL,
	[SequnceName] [nvarchar](100) NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_tblMasterTicketSequnces] PRIMARY KEY CLUSTERED 
(
	[SequanceIndexID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblMasterWarrenty]    Script Date: 13/03/2024 10:54:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMasterWarrenty](
	[mWarrentyId] [int] IDENTITY(1,1) NOT NULL,
	[inventoryId] [int] NULL,
	[WarrentyStartDate] [datetime] NULL,
	[Active] [bit] NULL,
	[WarrentyExpierdDate] [date] NULL,
	[ExpierReminderDate] [date] NULL,
	[WarrentyMonths] [int] NULL,
	[IsExpiered] [bit] NULL,
	[IsExtended] [bit] NULL,
 CONSTRAINT [PK_tblMasterWarrenty] PRIMARY KEY CLUSTERED 
(
	[mWarrentyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProductCategories]    Script Date: 13/03/2024 10:54:03 ******/
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
 CONSTRAINT [PK_tblProductCategories] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSalesDetails]    Script Date: 13/03/2024 10:54:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSalesDetails](
	[InvoiceID] [int] IDENTITY(1,1) NOT NULL,
	[InventoryId] [int] NULL,
	[CoustomerId] [int] NULL,
	[Discount] [decimal](18, 0) NULL,
	[SoldPrice] [decimal](18, 0) NULL,
	[CreatedDate] [datetime] NULL,
	[ExtendPrice] [decimal](18, 0) NULL,
 CONSTRAINT [PK_tblSalesDetails] PRIMARY KEY CLUSTERED 
(
	[InvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTicket]    Script Date: 13/03/2024 10:54:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTicket](
	[TicketId] [int] IDENTITY(1,1) NOT NULL,
	[InventoryID] [int] NULL,
	[CoustomerId] [int] NULL,
	[TicketDiscription] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[IsOpen] [bit] NULL,
	[IsClosed] [bit] NULL,
	[OpenedDate] [datetime] NULL,
	[ClosedDate] [datetime] NULL,
 CONSTRAINT [PK_tblTicket] PRIMARY KEY CLUSTERED 
(
	[TicketId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTicketComment]    Script Date: 13/03/2024 10:54:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTicketComment](
	[ticketCommentID] [int] IDENTITY(1,1) NOT NULL,
	[TicketID] [int] NULL,
	[Comment] [nvarchar](max) NULL,
	[CommentedDate] [datetime] NULL,
	[CommentedBy] [int] NULL,
 CONSTRAINT [PK_tblTicketComment] PRIMARY KEY CLUSTERED 
(
	[ticketCommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTicketProjectDtl]    Script Date: 13/03/2024 10:54:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTicketProjectDtl](
	[TicketProjectId] [int] IDENTITY(1,1) NOT NULL,
	[TicketId] [int] NULL,
	[CurrentSeqence] [int] NULL,
	[Active] [int] NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_tblTicketProjectDtl] PRIMARY KEY CLUSTERED 
(
	[TicketProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTicketStatus]    Script Date: 13/03/2024 10:54:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTicketStatus](
	[TicketStatusId] [int] IDENTITY(1,1) NOT NULL,
	[TicketStatus] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblTicketStatus] PRIMARY KEY CLUSTERED 
(
	[TicketStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTicketTaskAssign]    Script Date: 13/03/2024 10:54:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTicketTaskAssign](
	[TaslAssignId] [int] IDENTITY(1,1) NOT NULL,
	[ticketProjectId] [int] NULL,
	[AssignedFrom] [int] NULL,
	[AssignedTo] [int] NULL,
	[AssignedDate] [datetime] NULL,
	[Active] [bit] NULL,
	[StatustId] [int] NULL,
 CONSTRAINT [PK_tblTicketTaskAssign] PRIMARY KEY CLUSTERED 
(
	[TaslAssignId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 13/03/2024 10:54:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](30) NULL,
	[FirstName] [varchar](30) NULL,
	[LastName] [varchar](30) NULL,
	[DOB] [date] NULL,
	[Email] [nvarchar](80) NULL,
	[MobileNumber] [nchar](13) NULL,
	[UserLevel] [int] NULL,
	[Active] [bit] NULL,
	[Password] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[AssignedTicketSequnceGroup] [int] NULL,
 CONSTRAINT [PK_TblUser] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUserlLevel]    Script Date: 13/03/2024 10:54:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUserlLevel](
	[UserlevelID] [int] IDENTITY(1,1) NOT NULL,
	[UserLevel] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_TblUserlLevel] PRIMARY KEY CLUSTERED 
(
	[UserlevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblWarrentyExtendedDate]    Script Date: 13/03/2024 10:54:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblWarrentyExtendedDate](
	[weId] [int] IDENTITY(1,1) NOT NULL,
	[mWarrentyId] [int] NULL,
	[expiredDate] [datetime] NULL,
	[IsExpired] [bit] NULL,
	[IsWarrentyExtended] [bit] NULL,
	[warrentyExtendedFromDate] [datetime] NULL,
	[warrentyExtendedToDate] [datetime] NULL,
	[Active] [bit] NULL,
	[createddate] [datetime] NULL,
 CONSTRAINT [PK_tblWarrentyExtendedDate] PRIMARY KEY CLUSTERED 
(
	[weId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblWarrentyhistory]    Script Date: 13/03/2024 10:54:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblWarrentyhistory](
	[whId] [int] IDENTITY(1,1) NOT NULL,
	[mWarrentyId] [int] NULL,
	[comment] [nvarchar](max) NULL,
	[createdDate] [datetime] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_tblWarrentyhistory] PRIMARY KEY CLUSTERED 
(
	[whId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblCoustomerDetails] ON 

INSERT [dbo].[tblCoustomerDetails] ([CoustomerId], [CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active], [CreatedDate]) VALUES (1, N'buddhika perera', N'59/4 horana mabiliyakanda', N'sasankabudsadddhi@gmail.com', N'0768875415   ', N'buddhika', N'123456789', 1, CAST(N'2024-01-23T10:19:27.767' AS DateTime))
INSERT [dbo].[tblCoustomerDetails] ([CoustomerId], [CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active], [CreatedDate]) VALUES (2, N'buddhika perera', N'59/4 horana mabiliyakanda', N'sasankabudsadddhi@gmail.com', N'0768875415   ', N'buddhika', N'123456789', 1, CAST(N'2024-01-23T10:25:38.760' AS DateTime))
INSERT [dbo].[tblCoustomerDetails] ([CoustomerId], [CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active], [CreatedDate]) VALUES (3, N'buddhika perera', N'59/4 horana mabiliyakanda', N'sasankabudsadddhi@gmail.com', N'0768875415   ', N'buddhika', N'123456789', 1, CAST(N'2024-01-23T10:27:49.943' AS DateTime))
INSERT [dbo].[tblCoustomerDetails] ([CoustomerId], [CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active], [CreatedDate]) VALUES (4, N'buddhika perera', N'59/4 horana mabiliyakanda', N'sasankabudsadddhi@gmail.com', N'0768875415   ', N'buddhika', N'123456789', 1, CAST(N'2024-01-23T10:28:08.803' AS DateTime))
INSERT [dbo].[tblCoustomerDetails] ([CoustomerId], [CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active], [CreatedDate]) VALUES (5, N'buddhika perera', N'59/4 horana mabiliyakanda', N'sasankabudsadddhi@gmail.com', N'0768875415   ', N'buddhika', N'123456789', 1, CAST(N'2024-01-23T10:30:09.880' AS DateTime))
INSERT [dbo].[tblCoustomerDetails] ([CoustomerId], [CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active], [CreatedDate]) VALUES (6, N'buddhika perera', N'59/4 horana mabiliyakanda', N'sasankabudsadddhi@gmail.com', N'0768875415   ', N'buddhika', N'123456789', 1, CAST(N'2024-01-23T10:31:50.090' AS DateTime))
INSERT [dbo].[tblCoustomerDetails] ([CoustomerId], [CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active], [CreatedDate]) VALUES (7, N'buddhika perera', N'59/4 horana mabiliyakanda', N'sasankabudsadddhi@gmail.com', N'0768875415   ', N'buddhika', N'123456789', 1, CAST(N'2024-01-23T10:32:07.477' AS DateTime))
INSERT [dbo].[tblCoustomerDetails] ([CoustomerId], [CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active], [CreatedDate]) VALUES (8, N'buddhika perera', N'59/4 horana mabiliyakanda', N'sasankabudsadddhi@gmail.com', N'0768875415   ', N'buddhika', N'123456789', 1, CAST(N'2024-01-23T10:32:15.327' AS DateTime))
INSERT [dbo].[tblCoustomerDetails] ([CoustomerId], [CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active], [CreatedDate]) VALUES (9, N'buddhika perera', N'59/4 horana mabiliyakanda', N'sasankabudsadddhi@gmail.com', N'0768875415   ', N'buddhika', N'123456789', 1, CAST(N'2024-01-23T10:35:03.430' AS DateTime))
INSERT [dbo].[tblCoustomerDetails] ([CoustomerId], [CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active], [CreatedDate]) VALUES (11, N'a123f adad', N'fas af afaf a', N'sdadasd@gmail.com', N'864516541    ', N'a123f', N'12345678', 1, CAST(N'2024-01-23T11:49:44.053' AS DateTime))
INSERT [dbo].[tblCoustomerDetails] ([CoustomerId], [CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active], [CreatedDate]) VALUES (12, N'test darta', N'ada adad afd vaf afa', N'sdadad@gmail.com', N'0445678511   ', N'test', N'12345678', 1, CAST(N'2024-01-23T11:54:02.900' AS DateTime))
INSERT [dbo].[tblCoustomerDetails] ([CoustomerId], [CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active], [CreatedDate]) VALUES (13, N'dineth tharudhisi', N'kadwatha hasfjka', N'dinthe@gmail.com', N'07545612458  ', N'dineth', N'12345678', 1, CAST(N'2024-01-23T12:20:08.800' AS DateTime))
INSERT [dbo].[tblCoustomerDetails] ([CoustomerId], [CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active], [CreatedDate]) VALUES (14, N'Malsha Dilshani', N'adasd asdad ada', N'sadsdad@gmail.com', N'07645612378  ', N'Malsha', N'12345678', 1, CAST(N'2024-01-30T07:57:15.950' AS DateTime))
INSERT [dbo].[tblCoustomerDetails] ([CoustomerId], [CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active], [CreatedDate]) VALUES (15, N'SAMAN PERERA', N'54/4, Hoamgama rd, Homagama.', N'SAMANP@GMAIL.COM', N'0784565123   ', N'SAMAN', N'12345678', 1, CAST(N'2024-02-09T10:56:05.783' AS DateTime))
INSERT [dbo].[tblCoustomerDetails] ([CoustomerId], [CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active], [CreatedDate]) VALUES (16, N'saman ta', N'Nugegoda maharagama.', N'tasaman@gmail.com', N'0751234569   ', N'saman', N'12345678', 1, CAST(N'2024-02-09T14:58:51.423' AS DateTime))
INSERT [dbo].[tblCoustomerDetails] ([CoustomerId], [CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active], [CreatedDate]) VALUES (17, N'Charuna Amarasinghe', N'Horana rd, piliyandala', N'charuna@gmail.com', N'07512345687  ', N'Charuna', N'12345678', 1, CAST(N'2024-02-09T15:14:46.923' AS DateTime))
INSERT [dbo].[tblCoustomerDetails] ([CoustomerId], [CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active], [CreatedDate]) VALUES (18, N'Sandali gunasekara', N'Alauwa rd , thulhiriya', N'gunasekara15200@gmail.com', N'0761245652   ', N'Sandali', N'12345678', 1, CAST(N'2024-02-11T20:16:35.940' AS DateTime))
INSERT [dbo].[tblCoustomerDetails] ([CoustomerId], [CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active], [CreatedDate]) VALUES (19, N'caruna nimantha', N'horana panadura', N'nimanthac@gmail.com', N'0764551235   ', N'caruna', N'12345678', 1, CAST(N'2024-02-12T21:05:41.630' AS DateTime))
INSERT [dbo].[tblCoustomerDetails] ([CoustomerId], [CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active], [CreatedDate]) VALUES (20, N'Manel Sunendra', N'56/4 , Maharagama', N'sunendra@gmail.com', N'0785456214   ', N'Manel', N'12345678', 1, CAST(N'2024-02-16T18:55:48.747' AS DateTime))
INSERT [dbo].[tblCoustomerDetails] ([CoustomerId], [CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active], [CreatedDate]) VALUES (21, N'Saman perera', N'Horana rd, kahathuduwa', N'perera@gmail.com', N'0764512325   ', N'Saman', N'12345678', 1, CAST(N'2024-02-17T00:06:05.157' AS DateTime))
SET IDENTITY_INSERT [dbo].[tblCoustomerDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[tblInventoryData] ON 

INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (2, 4, 1, N'684EFW6S45EG6G4', 1, CAST(N'2023-12-28T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (3, 4, 1, N'465S4DG6SGAGRJS', 1, CAST(N'2023-12-28T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (4, 4, 1, N'SDH4GH6D5H1HS', NULL, NULL, 1, CAST(N'2023-12-29T00:00:00.000' AS DateTime))
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (5, 5, 2, N'G4SD65G4S65G4DG', 1, CAST(N'2023-11-25T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (6, 5, 2, N'6G4SDG68S4DG6SD4G', NULL, NULL, 1, CAST(N'2023-12-30T00:00:00.000' AS DateTime))
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (7, 6, NULL, N'SDG564SD4G6S5DG4S', 1, CAST(N'2024-01-03T11:29:27.717' AS DateTime), 0, NULL)
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (8, 5, 2, N'S5D1S321FG5J4DJS', 1, CAST(N'2024-01-03T11:32:07.323' AS DateTime), 0, NULL)
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (9, 5, 2, N'5646A5GEDG645GFG', 0, NULL, 1, CAST(N'2024-01-03T11:34:57.673' AS DateTime))
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (10, 5, 2, N'FDS54F65464GS132D', 0, NULL, 1, CAST(N'2024-01-03T11:49:11.187' AS DateTime))
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (11, 6, 3, N'S54GH6DG543DSD', 1, CAST(N'2024-01-03T12:03:49.367' AS DateTime), 0, NULL)
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (12, 5, 2, N'6456S5G4D6DG1S5D6G4', 0, NULL, 1, CAST(N'2024-01-03T12:33:58.073' AS DateTime))
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (13, 5, 2, N'SD64G5S4G6S4GG4', 1, CAST(N'2024-01-03T12:35:49.347' AS DateTime), 0, NULL)
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (14, 5, 2, N'SD56G4S6G4SDGS465', 1, CAST(N'2024-01-03T12:35:49.967' AS DateTime), 0, NULL)
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (15, 5, 2, N'T4H6TH4TYJ4T5J65', 1, CAST(N'2024-01-03T12:35:50.560' AS DateTime), 0, NULL)
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (16, 5, 2, N'6K4UY5J654H684GHRT', 1, CAST(N'2024-01-03T12:35:50.913' AS DateTime), 0, NULL)
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (17, 5, 2, N'6T84JHYT65H1464', 1, CAST(N'2024-01-03T12:35:51.153' AS DateTime), 0, NULL)
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (18, 5, 2, N'648GR684G6GD6584G', 1, CAST(N'2024-01-03T12:50:37.447' AS DateTime), 0, NULL)
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (19, 5, 2, N'GRE8G4RTH84UJUMG', 1, CAST(N'2024-01-03T12:50:44.007' AS DateTime), 0, NULL)
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (20, 5, 2, N'F64ESD6GEHY4JYR6J', 1, CAST(N'2024-01-03T12:50:49.527' AS DateTime), 0, NULL)
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (21, 5, 2, N'64ERG684H6T4T8HE8', 1, CAST(N'2024-01-03T12:51:33.050' AS DateTime), 0, NULL)
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (22, 4, 1, N'8E4RE4FDES52FS8S', 1, CAST(N'2024-01-03T12:58:19.590' AS DateTime), 0, NULL)
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (23, 5, 2, N'86R7EG65GR4GE68R4G', 1, CAST(N'2024-01-03T13:00:15.940' AS DateTime), 0, NULL)
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (24, 5, 2, N'68G4E6R4G32FE4E865RG', 1, CAST(N'2024-01-03T13:05:59.907' AS DateTime), 0, NULL)
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (25, 5, 2, N'H4T684HR64GH64SRG', 0, NULL, 1, CAST(N'2024-01-03T13:06:56.040' AS DateTime))
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (26, 5, 2, N'78EQWQR7W4654W65', 1, CAST(N'2024-01-03T13:13:26.890' AS DateTime), 0, NULL)
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (27, 5, 2, N'465EWRW21WE3R2', 0, NULL, 1, CAST(N'2024-01-03T13:18:07.730' AS DateTime))
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (28, 5, 2, N'31W3ER5WE4RW6ER84', 0, NULL, 1, CAST(N'2024-01-03T13:18:10.227' AS DateTime))
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (29, 5, 2, N'64W6ER4WE684RW2684', 0, NULL, 1, CAST(N'2024-01-03T13:18:13.090' AS DateTime))
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (30, 5, 2, N'874SGSGS64532SGDFSEFF', 0, NULL, 1, CAST(N'2024-01-03T13:18:17.620' AS DateTime))
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (31, 5, 2, N'4W65EGS53G4SD6G', 0, NULL, 1, CAST(N'2024-01-03T13:18:28.140' AS DateTime))
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (32, 4, 1, N'8746GSFGGSWGSXH45', 0, CAST(N'2024-01-03T13:19:18.673' AS DateTime), 1, CAST(N'2024-02-12T21:05:41.633' AS DateTime))
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (33, 4, 1, N'465GES5G46S86', 0, CAST(N'2024-01-03T13:20:57.490' AS DateTime), 1, CAST(N'2024-02-09T14:58:51.433' AS DateTime))
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (34, 5, 2, N'6R84G5G4D6G4S5', 0, CAST(N'2024-01-03T13:40:57.097' AS DateTime), 1, CAST(N'2024-02-09T10:56:05.830' AS DateTime))
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (35, 5, 2, N'64FE6S84FGS68G4', 0, CAST(N'2024-01-03T13:45:41.780' AS DateTime), 1, CAST(N'2024-01-30T07:57:16.777' AS DateTime))
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (1007, 5, 2, N'4SA65DA4S6D4AD3A4D65A3', 0, CAST(N'2024-02-09T15:13:41.667' AS DateTime), 1, CAST(N'2024-02-09T15:14:46.927' AS DateTime))
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (1008, 5, 2, N'564SD6A5D4A8S74DA5D54SAD', 0, CAST(N'2024-02-11T20:14:58.460' AS DateTime), 1, CAST(N'2024-02-11T20:16:35.940' AS DateTime))
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (1009, 5, 2, N'4D5G64SFG456GS6D54FGS46DSG4', 0, CAST(N'2024-02-16T18:54:09.390' AS DateTime), 1, CAST(N'2024-02-16T18:55:48.747' AS DateTime))
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (1010, 5, 2, N'FDASF45AFA564FAFD13A6456DA64FDA5641', 0, CAST(N'2024-02-17T00:05:10.193' AS DateTime), 1, CAST(N'2024-02-17T00:06:05.160' AS DateTime))
INSERT [dbo].[tblInventoryData] ([InventoryID], [ProductCategoryId], [MasterId], [SerialNumber], [ToTheStore], [InsertedDate], [ToTheOutside], [OutedDateFromStore]) VALUES (1011, 1006, NULL, N'AGAFA445FD4A68FS4AFG5A3G4AAF', 1, CAST(N'2024-03-09T23:15:55.177' AS DateTime), 0, NULL)
SET IDENTITY_INSERT [dbo].[tblInventoryData] OFF
GO
SET IDENTITY_INSERT [dbo].[tblMasterStore] ON 

INSERT [dbo].[tblMasterStore] ([mStoreId], [ProductId], [perchesedCount], [unitPrice], [PerchesedDate], [RecoredEnterdBy], [createdDate]) VALUES (1, 4, 100, CAST(125000 AS Decimal(18, 0)), CAST(N'2023-12-28T00:00:00.000' AS DateTime), 1, CAST(N'2023-12-28T00:00:00.000' AS DateTime))
INSERT [dbo].[tblMasterStore] ([mStoreId], [ProductId], [perchesedCount], [unitPrice], [PerchesedDate], [RecoredEnterdBy], [createdDate]) VALUES (2, 5, 50, CAST(250000 AS Decimal(18, 0)), CAST(N'2023-11-23T00:00:00.000' AS DateTime), 1, CAST(N'2023-12-28T00:00:00.000' AS DateTime))
INSERT [dbo].[tblMasterStore] ([mStoreId], [ProductId], [perchesedCount], [unitPrice], [PerchesedDate], [RecoredEnterdBy], [createdDate]) VALUES (3, 6, 102, CAST(1050 AS Decimal(18, 0)), CAST(N'2024-01-01T00:00:00.000' AS DateTime), 2, CAST(N'2024-01-03T12:02:36.350' AS DateTime))
INSERT [dbo].[tblMasterStore] ([mStoreId], [ProductId], [perchesedCount], [unitPrice], [PerchesedDate], [RecoredEnterdBy], [createdDate]) VALUES (1005, 5, 150, CAST(250000 AS Decimal(18, 0)), CAST(N'2023-04-01T00:00:00.000' AS DateTime), 2, CAST(N'2024-03-13T08:04:53.087' AS DateTime))
INSERT [dbo].[tblMasterStore] ([mStoreId], [ProductId], [perchesedCount], [unitPrice], [PerchesedDate], [RecoredEnterdBy], [createdDate]) VALUES (1006, 5, 2000, CAST(2 AS Decimal(18, 0)), CAST(N'2023-07-01T00:00:00.000' AS DateTime), 2, CAST(N'2024-03-13T08:08:21.383' AS DateTime))
SET IDENTITY_INSERT [dbo].[tblMasterStore] OFF
GO
SET IDENTITY_INSERT [dbo].[tblMasterTicketSequnces] ON 

INSERT [dbo].[tblMasterTicketSequnces] ([SequanceIndexID], [SequnceName], [Active]) VALUES (1, N'Ticket Cordinator', 1)
INSERT [dbo].[tblMasterTicketSequnces] ([SequanceIndexID], [SequnceName], [Active]) VALUES (2, N'Ticket Handler', 1)
INSERT [dbo].[tblMasterTicketSequnces] ([SequanceIndexID], [SequnceName], [Active]) VALUES (3, N'Ticket Manager', 1)
SET IDENTITY_INSERT [dbo].[tblMasterTicketSequnces] OFF
GO
SET IDENTITY_INSERT [dbo].[tblMasterWarrenty] ON 

INSERT [dbo].[tblMasterWarrenty] ([mWarrentyId], [inventoryId], [WarrentyStartDate], [Active], [WarrentyExpierdDate], [ExpierReminderDate], [WarrentyMonths], [IsExpiered], [IsExtended]) VALUES (1, NULL, CAST(N'2024-01-23T10:19:27.830' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tblMasterWarrenty] ([mWarrentyId], [inventoryId], [WarrentyStartDate], [Active], [WarrentyExpierdDate], [ExpierReminderDate], [WarrentyMonths], [IsExpiered], [IsExtended]) VALUES (2, 2, CAST(N'2024-01-23T10:25:38.760' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tblMasterWarrenty] ([mWarrentyId], [inventoryId], [WarrentyStartDate], [Active], [WarrentyExpierdDate], [ExpierReminderDate], [WarrentyMonths], [IsExpiered], [IsExtended]) VALUES (3, 2, CAST(N'2024-01-23T10:35:03.433' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tblMasterWarrenty] ([mWarrentyId], [inventoryId], [WarrentyStartDate], [Active], [WarrentyExpierdDate], [ExpierReminderDate], [WarrentyMonths], [IsExpiered], [IsExtended]) VALUES (4, 2, CAST(N'2024-01-23T11:41:47.240' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tblMasterWarrenty] ([mWarrentyId], [inventoryId], [WarrentyStartDate], [Active], [WarrentyExpierdDate], [ExpierReminderDate], [WarrentyMonths], [IsExpiered], [IsExtended]) VALUES (5, 2, CAST(N'2024-01-23T11:49:44.067' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tblMasterWarrenty] ([mWarrentyId], [inventoryId], [WarrentyStartDate], [Active], [WarrentyExpierdDate], [ExpierReminderDate], [WarrentyMonths], [IsExpiered], [IsExtended]) VALUES (6, 33, CAST(N'2024-01-23T11:54:02.903' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tblMasterWarrenty] ([mWarrentyId], [inventoryId], [WarrentyStartDate], [Active], [WarrentyExpierdDate], [ExpierReminderDate], [WarrentyMonths], [IsExpiered], [IsExtended]) VALUES (7, 33, CAST(N'2024-01-23T12:20:08.823' AS DateTime), 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tblMasterWarrenty] ([mWarrentyId], [inventoryId], [WarrentyStartDate], [Active], [WarrentyExpierdDate], [ExpierReminderDate], [WarrentyMonths], [IsExpiered], [IsExtended]) VALUES (8, 35, CAST(N'2024-01-30T07:57:17.630' AS DateTime), 1, CAST(N'2026-02-07' AS Date), CAST(N'2026-01-23' AS Date), 24, NULL, 1)
INSERT [dbo].[tblMasterWarrenty] ([mWarrentyId], [inventoryId], [WarrentyStartDate], [Active], [WarrentyExpierdDate], [ExpierReminderDate], [WarrentyMonths], [IsExpiered], [IsExtended]) VALUES (9, 34, CAST(N'2024-02-09T10:56:05.910' AS DateTime), 1, CAST(N'2026-02-09' AS Date), CAST(N'2026-02-02' AS Date), 24, NULL, NULL)
INSERT [dbo].[tblMasterWarrenty] ([mWarrentyId], [inventoryId], [WarrentyStartDate], [Active], [WarrentyExpierdDate], [ExpierReminderDate], [WarrentyMonths], [IsExpiered], [IsExtended]) VALUES (10, 33, CAST(N'2024-02-09T14:58:51.437' AS DateTime), 1, CAST(N'2026-02-09' AS Date), CAST(N'2026-02-02' AS Date), 24, NULL, NULL)
INSERT [dbo].[tblMasterWarrenty] ([mWarrentyId], [inventoryId], [WarrentyStartDate], [Active], [WarrentyExpierdDate], [ExpierReminderDate], [WarrentyMonths], [IsExpiered], [IsExtended]) VALUES (11, 1007, CAST(N'2024-02-09T15:14:46.927' AS DateTime), 1, CAST(N'2026-02-09' AS Date), CAST(N'2026-02-02' AS Date), 24, NULL, NULL)
INSERT [dbo].[tblMasterWarrenty] ([mWarrentyId], [inventoryId], [WarrentyStartDate], [Active], [WarrentyExpierdDate], [ExpierReminderDate], [WarrentyMonths], [IsExpiered], [IsExtended]) VALUES (12, 1008, CAST(N'2024-02-11T20:16:35.943' AS DateTime), 1, CAST(N'2026-02-11' AS Date), CAST(N'2026-02-04' AS Date), 24, NULL, NULL)
INSERT [dbo].[tblMasterWarrenty] ([mWarrentyId], [inventoryId], [WarrentyStartDate], [Active], [WarrentyExpierdDate], [ExpierReminderDate], [WarrentyMonths], [IsExpiered], [IsExtended]) VALUES (13, 32, CAST(N'2024-02-12T21:05:41.637' AS DateTime), 1, CAST(N'2026-02-12' AS Date), CAST(N'2026-02-05' AS Date), 24, NULL, NULL)
INSERT [dbo].[tblMasterWarrenty] ([mWarrentyId], [inventoryId], [WarrentyStartDate], [Active], [WarrentyExpierdDate], [ExpierReminderDate], [WarrentyMonths], [IsExpiered], [IsExtended]) VALUES (14, 1009, CAST(N'2024-02-16T18:55:48.753' AS DateTime), 1, CAST(N'2027-02-16' AS Date), CAST(N'2027-02-09' AS Date), 36, NULL, NULL)
INSERT [dbo].[tblMasterWarrenty] ([mWarrentyId], [inventoryId], [WarrentyStartDate], [Active], [WarrentyExpierdDate], [ExpierReminderDate], [WarrentyMonths], [IsExpiered], [IsExtended]) VALUES (15, 1010, CAST(N'2024-02-17T00:06:05.160' AS DateTime), 0, CAST(N'2026-02-18' AS Date), CAST(N'2026-02-10' AS Date), 24, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tblMasterWarrenty] OFF
GO
SET IDENTITY_INSERT [dbo].[tblProductCategories] ON 

INSERT [dbo].[tblProductCategories] ([ProductID], [BrandName], [VendorName], [VendorContact], [VendorAddress], [VendorEmail], [CreateDate], [Active], [ProductName]) VALUES (4, N'abanse', N'SInhagiri', N'0761554895   ', N'No 15, Maharagama Rd, Colombo', N'sinhagirimaharagama@gmail.com', CAST(N'2023-11-11T15:48:33.850' AS DateTime), 1, N'Abanse Laptop')
INSERT [dbo].[tblProductCategories] ([ProductID], [BrandName], [VendorName], [VendorContact], [VendorAddress], [VendorEmail], [CreateDate], [Active], [ProductName]) VALUES (5, N'Asus', N'Singar', N'0751234567   ', N'No 15, Maharagama Rd, Colombo', N'singar@gmail.com', CAST(N'2023-11-23T00:00:00.000' AS DateTime), 1, N'Asus VivoBook')
INSERT [dbo].[tblProductCategories] ([ProductID], [BrandName], [VendorName], [VendorContact], [VendorAddress], [VendorEmail], [CreateDate], [Active], [ProductName]) VALUES (6, N'aususss', N'lb', N'045127454    ', N'No 15, Maharagama Rd, Colombo 10', N'ausumaharagama@gmail.com', CAST(N'2024-01-03T11:58:18.527' AS DateTime), 1, N'mouse')
SET IDENTITY_INSERT [dbo].[tblProductCategories] OFF
GO
SET IDENTITY_INSERT [dbo].[tblSalesDetails] ON 

INSERT [dbo].[tblSalesDetails] ([InvoiceID], [InventoryId], [CoustomerId], [Discount], [SoldPrice], [CreatedDate], [ExtendPrice]) VALUES (1, 2, 9, CAST(1000 AS Decimal(18, 0)), CAST(5000 AS Decimal(18, 0)), CAST(N'2024-01-23T10:35:03.433' AS DateTime), NULL)
INSERT [dbo].[tblSalesDetails] ([InvoiceID], [InventoryId], [CoustomerId], [Discount], [SoldPrice], [CreatedDate], [ExtendPrice]) VALUES (2, 2, NULL, CAST(1000 AS Decimal(18, 0)), CAST(186389 AS Decimal(18, 0)), CAST(N'2024-01-23T11:41:47.210' AS DateTime), NULL)
INSERT [dbo].[tblSalesDetails] ([InvoiceID], [InventoryId], [CoustomerId], [Discount], [SoldPrice], [CreatedDate], [ExtendPrice]) VALUES (3, 2, 11, CAST(1000 AS Decimal(18, 0)), CAST(186389 AS Decimal(18, 0)), CAST(N'2024-01-23T11:49:44.067' AS DateTime), NULL)
INSERT [dbo].[tblSalesDetails] ([InvoiceID], [InventoryId], [CoustomerId], [Discount], [SoldPrice], [CreatedDate], [ExtendPrice]) VALUES (4, 33, 12, CAST(1000 AS Decimal(18, 0)), CAST(186389 AS Decimal(18, 0)), CAST(N'2024-01-23T11:54:02.903' AS DateTime), NULL)
INSERT [dbo].[tblSalesDetails] ([InvoiceID], [InventoryId], [CoustomerId], [Discount], [SoldPrice], [CreatedDate], [ExtendPrice]) VALUES (5, 33, 13, CAST(1000 AS Decimal(18, 0)), CAST(186389 AS Decimal(18, 0)), CAST(N'2024-01-23T12:20:08.803' AS DateTime), NULL)
INSERT [dbo].[tblSalesDetails] ([InvoiceID], [InventoryId], [CoustomerId], [Discount], [SoldPrice], [CreatedDate], [ExtendPrice]) VALUES (6, 35, 14, CAST(1000 AS Decimal(18, 0)), CAST(373889 AS Decimal(18, 0)), CAST(N'2024-01-30T07:57:16.540' AS DateTime), NULL)
INSERT [dbo].[tblSalesDetails] ([InvoiceID], [InventoryId], [CoustomerId], [Discount], [SoldPrice], [CreatedDate], [ExtendPrice]) VALUES (7, 35, 14, NULL, NULL, CAST(N'2024-02-06T14:27:07.063' AS DateTime), CAST(14956 AS Decimal(18, 0)))
INSERT [dbo].[tblSalesDetails] ([InvoiceID], [InventoryId], [CoustomerId], [Discount], [SoldPrice], [CreatedDate], [ExtendPrice]) VALUES (8, 35, 14, NULL, NULL, CAST(N'2024-02-07T13:23:41.810' AS DateTime), CAST(14956 AS Decimal(18, 0)))
INSERT [dbo].[tblSalesDetails] ([InvoiceID], [InventoryId], [CoustomerId], [Discount], [SoldPrice], [CreatedDate], [ExtendPrice]) VALUES (9, 35, 14, NULL, NULL, CAST(N'2024-02-07T13:46:14.927' AS DateTime), CAST(14956 AS Decimal(18, 0)))
INSERT [dbo].[tblSalesDetails] ([InvoiceID], [InventoryId], [CoustomerId], [Discount], [SoldPrice], [CreatedDate], [ExtendPrice]) VALUES (10, 34, 15, CAST(0 AS Decimal(18, 0)), CAST(375000 AS Decimal(18, 0)), CAST(N'2024-02-09T10:56:05.827' AS DateTime), NULL)
INSERT [dbo].[tblSalesDetails] ([InvoiceID], [InventoryId], [CoustomerId], [Discount], [SoldPrice], [CreatedDate], [ExtendPrice]) VALUES (11, 33, 16, CAST(0 AS Decimal(18, 0)), CAST(187500 AS Decimal(18, 0)), CAST(N'2024-02-09T14:58:51.433' AS DateTime), NULL)
INSERT [dbo].[tblSalesDetails] ([InvoiceID], [InventoryId], [CoustomerId], [Discount], [SoldPrice], [CreatedDate], [ExtendPrice]) VALUES (12, 1007, 17, CAST(0 AS Decimal(18, 0)), CAST(375000 AS Decimal(18, 0)), CAST(N'2024-02-09T15:14:46.923' AS DateTime), NULL)
INSERT [dbo].[tblSalesDetails] ([InvoiceID], [InventoryId], [CoustomerId], [Discount], [SoldPrice], [CreatedDate], [ExtendPrice]) VALUES (13, 1008, 18, CAST(0 AS Decimal(18, 0)), CAST(375000 AS Decimal(18, 0)), CAST(N'2024-02-11T20:16:35.940' AS DateTime), NULL)
INSERT [dbo].[tblSalesDetails] ([InvoiceID], [InventoryId], [CoustomerId], [Discount], [SoldPrice], [CreatedDate], [ExtendPrice]) VALUES (14, 32, 19, CAST(0 AS Decimal(18, 0)), CAST(187500 AS Decimal(18, 0)), CAST(N'2024-02-12T21:05:41.633' AS DateTime), NULL)
INSERT [dbo].[tblSalesDetails] ([InvoiceID], [InventoryId], [CoustomerId], [Discount], [SoldPrice], [CreatedDate], [ExtendPrice]) VALUES (15, 1009, 20, CAST(0 AS Decimal(18, 0)), CAST(406250 AS Decimal(18, 0)), CAST(N'2024-02-16T18:55:48.747' AS DateTime), NULL)
INSERT [dbo].[tblSalesDetails] ([InvoiceID], [InventoryId], [CoustomerId], [Discount], [SoldPrice], [CreatedDate], [ExtendPrice]) VALUES (16, 1010, 21, CAST(0 AS Decimal(18, 0)), CAST(375000 AS Decimal(18, 0)), CAST(N'2024-02-17T00:06:05.157' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[tblSalesDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[tblTicket] ON 

INSERT [dbo].[tblTicket] ([TicketId], [InventoryID], [CoustomerId], [TicketDiscription], [CreatedDate], [IsOpen], [IsClosed], [OpenedDate], [ClosedDate]) VALUES (1, 35, 14, N'Test', CAST(N'2024-02-08T11:30:00.000' AS DateTime), 0, 1, CAST(N'2024-02-18T11:30:00.000' AS DateTime), CAST(N'2024-03-12T21:25:22.800' AS DateTime))
INSERT [dbo].[tblTicket] ([TicketId], [InventoryID], [CoustomerId], [TicketDiscription], [CreatedDate], [IsOpen], [IsClosed], [OpenedDate], [ClosedDate]) VALUES (2, 34, 15, N'Test 2024 02 09', CAST(N'2024-02-09T10:58:00.000' AS DateTime), 0, 1, CAST(N'2024-02-09T00:00:00.000' AS DateTime), CAST(N'2024-03-12T21:25:22.800' AS DateTime))
INSERT [dbo].[tblTicket] ([TicketId], [InventoryID], [CoustomerId], [TicketDiscription], [CreatedDate], [IsOpen], [IsClosed], [OpenedDate], [ClosedDate]) VALUES (3, 33, 16, N'Test 2024 02 09 v02', CAST(N'2024-02-09T15:01:00.000' AS DateTime), 1, 1, CAST(N'2024-02-09T15:02:06.263' AS DateTime), CAST(N'2024-03-12T21:25:22.800' AS DateTime))
INSERT [dbo].[tblTicket] ([TicketId], [InventoryID], [CoustomerId], [TicketDiscription], [CreatedDate], [IsOpen], [IsClosed], [OpenedDate], [ClosedDate]) VALUES (4, 1007, 17, N'test by charuna', CAST(N'2024-02-09T16:00:00.000' AS DateTime), 1, 1, CAST(N'2024-02-09T15:16:16.410' AS DateTime), CAST(N'2024-03-12T21:25:22.800' AS DateTime))
INSERT [dbo].[tblTicket] ([TicketId], [InventoryID], [CoustomerId], [TicketDiscription], [CreatedDate], [IsOpen], [IsClosed], [OpenedDate], [ClosedDate]) VALUES (5, 1007, 17, N'test 2', CAST(N'2024-02-09T17:00:00.000' AS DateTime), 1, 1, CAST(N'2024-02-09T15:22:52.797' AS DateTime), CAST(N'2024-03-12T21:25:22.800' AS DateTime))
INSERT [dbo].[tblTicket] ([TicketId], [InventoryID], [CoustomerId], [TicketDiscription], [CreatedDate], [IsOpen], [IsClosed], [OpenedDate], [ClosedDate]) VALUES (6, 1008, 18, N'test ticket assig', CAST(N'2024-02-11T00:00:00.000' AS DateTime), 0, 1, NULL, CAST(N'2024-03-12T21:25:22.800' AS DateTime))
INSERT [dbo].[tblTicket] ([TicketId], [InventoryID], [CoustomerId], [TicketDiscription], [CreatedDate], [IsOpen], [IsClosed], [OpenedDate], [ClosedDate]) VALUES (7, 35, 14, N'test', CAST(N'2024-02-12T20:57:54.983' AS DateTime), 0, 1, NULL, CAST(N'2024-03-12T21:25:22.800' AS DateTime))
INSERT [dbo].[tblTicket] ([TicketId], [InventoryID], [CoustomerId], [TicketDiscription], [CreatedDate], [IsOpen], [IsClosed], [OpenedDate], [ClosedDate]) VALUES (8, 35, 14, N'testtt', CAST(N'2024-02-12T21:04:52.847' AS DateTime), 0, 1, NULL, CAST(N'2024-03-12T21:25:22.800' AS DateTime))
INSERT [dbo].[tblTicket] ([TicketId], [InventoryID], [CoustomerId], [TicketDiscription], [CreatedDate], [IsOpen], [IsClosed], [OpenedDate], [ClosedDate]) VALUES (9, 32, 19, N'test t', CAST(N'2024-02-12T21:06:11.540' AS DateTime), 0, 1, CAST(N'2024-02-12T21:32:41.227' AS DateTime), CAST(N'2024-03-12T21:25:22.800' AS DateTime))
INSERT [dbo].[tblTicket] ([TicketId], [InventoryID], [CoustomerId], [TicketDiscription], [CreatedDate], [IsOpen], [IsClosed], [OpenedDate], [ClosedDate]) VALUES (10, 1009, 20, N'Test Ticket  by UI', CAST(N'2024-02-16T18:56:03.930' AS DateTime), 1, 1, CAST(N'2024-02-16T18:56:46.643' AS DateTime), CAST(N'2024-03-12T21:25:22.800' AS DateTime))
INSERT [dbo].[tblTicket] ([TicketId], [InventoryID], [CoustomerId], [TicketDiscription], [CreatedDate], [IsOpen], [IsClosed], [OpenedDate], [ClosedDate]) VALUES (11, 1010, 21, N'Test ticket bu UI to check null logged user and ticket assign sp', CAST(N'2024-02-17T00:11:14.740' AS DateTime), 1, 1, CAST(N'2024-02-17T00:11:58.000' AS DateTime), CAST(N'2024-03-12T21:25:22.800' AS DateTime))
INSERT [dbo].[tblTicket] ([TicketId], [InventoryID], [CoustomerId], [TicketDiscription], [CreatedDate], [IsOpen], [IsClosed], [OpenedDate], [ClosedDate]) VALUES (12, 1010, 21, N'test ticket 2', CAST(N'2024-02-17T00:38:11.940' AS DateTime), 1, 1, CAST(N'2024-02-17T00:38:40.173' AS DateTime), CAST(N'2024-03-12T21:25:22.800' AS DateTime))
INSERT [dbo].[tblTicket] ([TicketId], [InventoryID], [CoustomerId], [TicketDiscription], [CreatedDate], [IsOpen], [IsClosed], [OpenedDate], [ClosedDate]) VALUES (13, 1010, 21, N'3rd test ticket from same serial number', CAST(N'2024-02-17T00:45:22.213' AS DateTime), 1, 1, CAST(N'2024-02-17T00:45:43.933' AS DateTime), CAST(N'2024-03-12T21:25:22.800' AS DateTime))
INSERT [dbo].[tblTicket] ([TicketId], [InventoryID], [CoustomerId], [TicketDiscription], [CreatedDate], [IsOpen], [IsClosed], [OpenedDate], [ClosedDate]) VALUES (14, 1010, 21, N'4th ticket from same serial number to check sp_assign ticket comment', CAST(N'2024-02-17T00:48:58.157' AS DateTime), 1, 1, CAST(N'2024-02-17T00:49:18.957' AS DateTime), CAST(N'2024-03-12T21:25:22.800' AS DateTime))
INSERT [dbo].[tblTicket] ([TicketId], [InventoryID], [CoustomerId], [TicketDiscription], [CreatedDate], [IsOpen], [IsClosed], [OpenedDate], [ClosedDate]) VALUES (15, 1010, 21, N'Test Ticket to check user by user', CAST(N'2024-02-17T20:51:16.900' AS DateTime), 1, 1, CAST(N'2024-02-17T20:52:09.897' AS DateTime), CAST(N'2024-03-12T21:25:22.800' AS DateTime))
INSERT [dbo].[tblTicket] ([TicketId], [InventoryID], [CoustomerId], [TicketDiscription], [CreatedDate], [IsOpen], [IsClosed], [OpenedDate], [ClosedDate]) VALUES (16, 35, 14, N'text by admin - text ticket assign sp to check current level', CAST(N'2024-02-17T21:28:12.323' AS DateTime), 1, 1, CAST(N'2024-02-17T21:29:01.800' AS DateTime), CAST(N'2024-03-12T21:25:22.800' AS DateTime))
INSERT [dbo].[tblTicket] ([TicketId], [InventoryID], [CoustomerId], [TicketDiscription], [CreatedDate], [IsOpen], [IsClosed], [OpenedDate], [ClosedDate]) VALUES (17, 1010, 21, N'test all', CAST(N'2024-02-17T22:22:48.187' AS DateTime), 1, 1, CAST(N'2024-02-17T22:23:43.990' AS DateTime), CAST(N'2024-03-12T21:25:22.800' AS DateTime))
INSERT [dbo].[tblTicket] ([TicketId], [InventoryID], [CoustomerId], [TicketDiscription], [CreatedDate], [IsOpen], [IsClosed], [OpenedDate], [ClosedDate]) VALUES (18, 1010, 21, N'tetst ticket', CAST(N'2024-02-17T22:27:42.667' AS DateTime), 1, 1, CAST(N'2024-02-17T22:28:20.917' AS DateTime), CAST(N'2024-03-12T21:25:22.800' AS DateTime))
SET IDENTITY_INSERT [dbo].[tblTicket] OFF
GO
SET IDENTITY_INSERT [dbo].[tblTicketComment] ON 

INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (4, 3, N'Ticket Submitted by Handler1 .', CAST(N'2024-02-09T15:10:00.130' AS DateTime), 4)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (5, 3, N'Ticket Accepted by Manager1 .', CAST(N'2024-02-09T15:10:24.960' AS DateTime), 6)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (6, 3, N'Ticket Accepted by Manager1 .', CAST(N'2024-02-09T15:10:50.443' AS DateTime), 6)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (7, 3, N'Ticket Submitted by Manager1 .', CAST(N'2024-02-09T15:11:13.283' AS DateTime), 6)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (8, 3, NULL, CAST(N'2024-02-09T15:11:42.887' AS DateTime), NULL)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (9, 4, NULL, CAST(N'2024-02-09T15:16:16.413' AS DateTime), 3)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (10, 4, N'Ticket Accepted by Handler1 .', CAST(N'2024-02-09T15:17:42.833' AS DateTime), 4)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (11, 4, N'Ticket Submitted by Handler1 .', CAST(N'2024-02-09T15:17:47.253' AS DateTime), 4)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (12, 4, N'Ticket Accepted by Manager1 .', CAST(N'2024-02-09T15:17:51.450' AS DateTime), 6)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (13, 4, N'Ticket Submitted by Manager1 .', CAST(N'2024-02-09T15:17:58.340' AS DateTime), 6)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (14, 4, N'Ticket Closed by Manager1 .', CAST(N'2024-02-09T15:19:12.170' AS DateTime), 6)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (15, 5, NULL, CAST(N'2024-02-09T15:22:52.800' AS DateTime), 3)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (16, 5, N'Ticket Accepted by Handler1 .', CAST(N'2024-02-09T15:24:33.413' AS DateTime), 4)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (17, 5, N'Ticket Submitted by Handler1 .', CAST(N'2024-02-09T15:24:36.787' AS DateTime), 4)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (18, 5, N'Ticket Accepted by Manager1 .', CAST(N'2024-02-09T15:24:39.380' AS DateTime), 6)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (19, 5, N'Ticket Closed by Manager1 .', CAST(N'2024-02-09T15:24:41.820' AS DateTime), 6)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (20, 3, N'Ticket Accepted by Handler1 ', CAST(N'2024-02-09T15:26:14.640' AS DateTime), 4)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (21, 3, N'Ticket Accepted by Handler1 ', CAST(N'2024-02-09T15:26:15.003' AS DateTime), 4)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (22, 9, NULL, CAST(N'2024-02-12T21:32:41.230' AS DateTime), 2)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (23, 9, N'Ticket Accepted by Handler1 ', CAST(N'2024-02-12T22:11:36.390' AS DateTime), 4)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (24, 9, N'Ticket Submitted by Handler1 ', CAST(N'2024-02-12T22:11:55.213' AS DateTime), 4)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (25, 9, N'Ticket Accepted by Manager1 ', CAST(N'2024-02-12T22:12:13.137' AS DateTime), 6)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (26, 9, N'Ticket Closed by Manager1 ', CAST(N'2024-02-12T22:12:33.100' AS DateTime), 6)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (27, 10, N'Ticket Assign by Manually', CAST(N'2024-02-16T18:56:46.650' AS DateTime), 3)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (28, 11, N'Comment Inserted by Manually', CAST(N'2024-02-17T00:11:58.003' AS DateTime), 2)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (29, 11, N'Comment Inserted by Manually', CAST(N'2024-02-17T00:15:15.547' AS DateTime), 2)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (30, 12, N'Ticket Open and Assigned From Ticket Hanlder Level', CAST(N'2024-02-17T00:38:40.173' AS DateTime), 2)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (31, 13, N'Ticket Open and Assigned From Ticket Hanlder Level', CAST(N'2024-02-17T00:45:43.933' AS DateTime), 2)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (32, 11, NULL, CAST(N'2024-02-17T00:45:43.933' AS DateTime), 2)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (33, 14, N'Ticket Open and Assigned From Ticket Hanlder Level', CAST(N'2024-02-17T00:49:18.960' AS DateTime), 2)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (34, 14, N'Ticket Open and Assigned From Admin To Handler1', CAST(N'2024-02-17T00:49:18.960' AS DateTime), 2)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (35, 15, N'Ticket Open and Assigned From Admin To Handler2', CAST(N'2024-02-17T20:52:09.900' AS DateTime), 2)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (36, 16, N'Ticket Open and Assigned From Coordinator1 To Handler2', CAST(N'2024-02-17T21:29:01.803' AS DateTime), 3)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (37, 16, N'Ticket Accepted by Handler2 ', CAST(N'2024-02-17T21:45:34.553' AS DateTime), 5)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (38, 16, N'Ticket Accepted by Handler2 ', CAST(N'2024-02-17T21:49:47.760' AS DateTime), 5)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (39, 16, N'Ticket Closed by Handler2 ', CAST(N'2024-02-17T21:50:31.383' AS DateTime), 5)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (40, 17, N'Ticket Open and Assigned From Coordinator1 To Handler2', CAST(N'2024-02-17T22:23:43.990' AS DateTime), 3)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (41, 17, N'Ticket Accepted by Handler2 ', CAST(N'2024-02-17T22:24:17.070' AS DateTime), 5)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (42, 17, N'Ticket Submitted by Handler2 ', CAST(N'2024-02-17T22:24:30.620' AS DateTime), 5)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (43, 17, N'Ticket Closed by Manager1 ', CAST(N'2024-02-17T22:25:22.270' AS DateTime), 6)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (44, 17, NULL, CAST(N'2024-02-17T22:26:31.100' AS DateTime), NULL)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (45, 17, NULL, CAST(N'2024-02-17T22:26:37.773' AS DateTime), NULL)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (46, 18, N'Ticket Open and Assigned From Coordinator1 To Handler2', CAST(N'2024-02-17T22:28:20.917' AS DateTime), 3)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (47, 18, N'Ticket Accepted by Handler2 ', CAST(N'2024-02-17T22:29:44.933' AS DateTime), 5)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (48, 18, N'Ticket Submitted by Handler2 ', CAST(N'2024-02-17T22:30:44.583' AS DateTime), 5)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (49, 18, N'Ticket Accepted by Manager1 ', CAST(N'2024-02-17T22:33:09.007' AS DateTime), 6)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (50, 18, N'Ticket Closed by Manager1 ', CAST(N'2024-02-17T22:33:41.347' AS DateTime), 6)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (51, 15, N'Ticket Accepted by Handler2 ', CAST(N'2024-03-12T21:25:14.850' AS DateTime), 5)
INSERT [dbo].[tblTicketComment] ([ticketCommentID], [TicketID], [Comment], [CommentedDate], [CommentedBy]) VALUES (52, 15, N'Ticket Closed by Handler2 ', CAST(N'2024-03-12T21:25:22.800' AS DateTime), 5)
SET IDENTITY_INSERT [dbo].[tblTicketComment] OFF
GO
SET IDENTITY_INSERT [dbo].[tblTicketProjectDtl] ON 

INSERT [dbo].[tblTicketProjectDtl] ([TicketProjectId], [TicketId], [CurrentSeqence], [Active], [CreateDate]) VALUES (2, 1, 2, 1, CAST(N'2024-02-08T13:01:38.717' AS DateTime))
INSERT [dbo].[tblTicketProjectDtl] ([TicketProjectId], [TicketId], [CurrentSeqence], [Active], [CreateDate]) VALUES (3, 2, 3, 0, CAST(N'2024-02-09T11:59:01.680' AS DateTime))
INSERT [dbo].[tblTicketProjectDtl] ([TicketProjectId], [TicketId], [CurrentSeqence], [Active], [CreateDate]) VALUES (4, 3, 3, 0, CAST(N'2024-02-09T15:02:06.263' AS DateTime))
INSERT [dbo].[tblTicketProjectDtl] ([TicketProjectId], [TicketId], [CurrentSeqence], [Active], [CreateDate]) VALUES (5, 4, 3, 0, CAST(N'2024-02-09T15:16:16.410' AS DateTime))
INSERT [dbo].[tblTicketProjectDtl] ([TicketProjectId], [TicketId], [CurrentSeqence], [Active], [CreateDate]) VALUES (6, 5, 2, 0, CAST(N'2024-02-09T15:22:52.797' AS DateTime))
INSERT [dbo].[tblTicketProjectDtl] ([TicketProjectId], [TicketId], [CurrentSeqence], [Active], [CreateDate]) VALUES (7, 9, 2, 0, CAST(N'2024-02-12T21:32:41.230' AS DateTime))
INSERT [dbo].[tblTicketProjectDtl] ([TicketProjectId], [TicketId], [CurrentSeqence], [Active], [CreateDate]) VALUES (8, 10, 1, 1, CAST(N'2024-02-16T18:56:46.643' AS DateTime))
INSERT [dbo].[tblTicketProjectDtl] ([TicketProjectId], [TicketId], [CurrentSeqence], [Active], [CreateDate]) VALUES (9, 11, 1, 1, CAST(N'2024-02-17T00:11:58.003' AS DateTime))
INSERT [dbo].[tblTicketProjectDtl] ([TicketProjectId], [TicketId], [CurrentSeqence], [Active], [CreateDate]) VALUES (10, 12, 1, 1, CAST(N'2024-02-17T00:38:40.173' AS DateTime))
INSERT [dbo].[tblTicketProjectDtl] ([TicketProjectId], [TicketId], [CurrentSeqence], [Active], [CreateDate]) VALUES (11, 13, 1, 1, CAST(N'2024-02-17T00:45:43.933' AS DateTime))
INSERT [dbo].[tblTicketProjectDtl] ([TicketProjectId], [TicketId], [CurrentSeqence], [Active], [CreateDate]) VALUES (12, 14, 1, 1, CAST(N'2024-02-17T00:49:18.960' AS DateTime))
INSERT [dbo].[tblTicketProjectDtl] ([TicketProjectId], [TicketId], [CurrentSeqence], [Active], [CreateDate]) VALUES (13, 15, 2, 0, CAST(N'2024-02-17T20:52:09.897' AS DateTime))
INSERT [dbo].[tblTicketProjectDtl] ([TicketProjectId], [TicketId], [CurrentSeqence], [Active], [CreateDate]) VALUES (14, 16, 2, 0, CAST(N'2024-02-17T21:29:01.800' AS DateTime))
INSERT [dbo].[tblTicketProjectDtl] ([TicketProjectId], [TicketId], [CurrentSeqence], [Active], [CreateDate]) VALUES (15, 17, 3, 0, CAST(N'2024-02-17T22:23:43.990' AS DateTime))
INSERT [dbo].[tblTicketProjectDtl] ([TicketProjectId], [TicketId], [CurrentSeqence], [Active], [CreateDate]) VALUES (16, 18, 3, 0, CAST(N'2024-02-17T22:28:20.917' AS DateTime))
SET IDENTITY_INSERT [dbo].[tblTicketProjectDtl] OFF
GO
SET IDENTITY_INSERT [dbo].[tblTicketStatus] ON 

INSERT [dbo].[tblTicketStatus] ([TicketStatusId], [TicketStatus]) VALUES (1, N'Pending')
INSERT [dbo].[tblTicketStatus] ([TicketStatusId], [TicketStatus]) VALUES (2, N'Accepted')
INSERT [dbo].[tblTicketStatus] ([TicketStatusId], [TicketStatus]) VALUES (3, N'Submitted')
INSERT [dbo].[tblTicketStatus] ([TicketStatusId], [TicketStatus]) VALUES (4, N'Rejected')
INSERT [dbo].[tblTicketStatus] ([TicketStatusId], [TicketStatus]) VALUES (5, N'Close')
SET IDENTITY_INSERT [dbo].[tblTicketStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[tblTicketTaskAssign] ON 

INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (1, 2, 3, 4, CAST(N'2024-02-08T16:00:00.000' AS DateTime), 0, 3)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (2, 2, 4, 6, CAST(N'2024-02-09T10:38:36.997' AS DateTime), 0, 4)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (3, 2, 6, 4, CAST(N'2024-02-09T10:38:59.350' AS DateTime), 1, 1)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (4, 3, 3, 4, CAST(N'2024-02-09T11:59:01.693' AS DateTime), 0, 3)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (5, 3, 4, 6, CAST(N'2024-02-09T12:00:54.240' AS DateTime), 0, 4)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (6, 3, 6, 4, CAST(N'2024-02-09T12:01:51.640' AS DateTime), 0, 3)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (7, 3, 4, 6, CAST(N'2024-02-09T12:02:38.730' AS DateTime), 0, 4)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (8, 3, 6, 4, CAST(N'2024-02-09T12:05:37.453' AS DateTime), 0, 3)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (9, 3, 4, 6, CAST(N'2024-02-09T12:06:28.550' AS DateTime), 0, 5)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (10, 4, 3, 4, CAST(N'2024-02-09T15:02:06.263' AS DateTime), 0, 3)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (11, 4, 4, 6, CAST(N'2024-02-09T15:10:00.130' AS DateTime), 0, 3)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (12, 4, 6, NULL, CAST(N'2024-02-09T15:11:13.283' AS DateTime), 0, 5)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (13, 5, 3, 4, CAST(N'2024-02-09T15:16:16.413' AS DateTime), 0, 3)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (14, 5, 4, 6, CAST(N'2024-02-09T15:17:47.253' AS DateTime), 0, 3)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (15, 5, 6, 6, CAST(N'2024-02-09T15:17:58.340' AS DateTime), 0, 5)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (16, 6, 3, 4, CAST(N'2024-02-09T15:22:52.797' AS DateTime), 0, 3)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (17, 6, 4, 6, CAST(N'2024-02-09T15:24:36.783' AS DateTime), 0, 5)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (18, 7, 2, 4, CAST(N'2024-02-12T21:32:41.230' AS DateTime), 0, 3)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (19, 7, 4, 6, CAST(N'2024-02-12T22:11:55.213' AS DateTime), 0, 5)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (21, 8, 3, 4, CAST(N'2024-02-16T19:02:06.000' AS DateTime), 1, 1)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (22, 9, 2, 4, CAST(N'2024-02-17T00:11:58.003' AS DateTime), 1, 1)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (23, 10, 2, 4, CAST(N'2024-02-17T00:38:40.173' AS DateTime), 1, 1)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (24, 11, 2, 4, CAST(N'2024-02-17T00:45:43.933' AS DateTime), 1, 1)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (25, 12, 2, 4, CAST(N'2024-02-17T00:49:18.960' AS DateTime), 1, 1)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (26, 13, 2, 5, CAST(N'2024-02-17T20:52:09.897' AS DateTime), 0, 5)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (27, 14, 3, 5, CAST(N'2024-02-17T21:29:01.803' AS DateTime), 0, 5)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (28, 15, 3, 5, CAST(N'2024-02-17T22:23:43.990' AS DateTime), 0, 3)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (29, 15, 5, 6, CAST(N'2024-02-17T22:24:30.620' AS DateTime), 0, 5)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (30, 16, 3, 5, CAST(N'2024-02-17T22:28:20.917' AS DateTime), 0, 3)
INSERT [dbo].[tblTicketTaskAssign] ([TaslAssignId], [ticketProjectId], [AssignedFrom], [AssignedTo], [AssignedDate], [Active], [StatustId]) VALUES (31, 16, 5, 6, CAST(N'2024-02-17T22:30:44.580' AS DateTime), 0, 5)
SET IDENTITY_INSERT [dbo].[tblTicketTaskAssign] OFF
GO
SET IDENTITY_INSERT [dbo].[tblUser] ON 

INSERT [dbo].[tblUser] ([UserId], [UserName], [FirstName], [LastName], [DOB], [Email], [MobileNumber], [UserLevel], [Active], [Password], [CreatedDate], [AssignedTicketSequnceGroup]) VALUES (2, N'Admin', N'Sasanka', N'Buddhi', CAST(N'2000-07-30' AS Date), N'sasanka@gmail.com', N'0761885932   ', 1, 1, N'123456789', CAST(N'2023-11-02T21:07:34.350' AS DateTime), NULL)
INSERT [dbo].[tblUser] ([UserId], [UserName], [FirstName], [LastName], [DOB], [Email], [MobileNumber], [UserLevel], [Active], [Password], [CreatedDate], [AssignedTicketSequnceGroup]) VALUES (3, N'Coordinator1', N'Ticket', N'Coordinator', CAST(N'2000-07-31' AS Date), N'sasankabuddhi2@gmail.com', N'0761885933   ', 3, 1, N'123456789', CAST(N'2023-11-02T21:21:25.033' AS DateTime), 1)
INSERT [dbo].[tblUser] ([UserId], [UserName], [FirstName], [LastName], [DOB], [Email], [MobileNumber], [UserLevel], [Active], [Password], [CreatedDate], [AssignedTicketSequnceGroup]) VALUES (4, N'Handler1', N'Ticket', N'Handler', CAST(N'2000-08-01' AS Date), N'sasanka3@gmail.com', N'0761885934   ', 4, 1, N'123456789', CAST(N'2023-11-02T21:21:25.033' AS DateTime), 2)
INSERT [dbo].[tblUser] ([UserId], [UserName], [FirstName], [LastName], [DOB], [Email], [MobileNumber], [UserLevel], [Active], [Password], [CreatedDate], [AssignedTicketSequnceGroup]) VALUES (5, N'Handler2', N'Ticket', N'Handler2', CAST(N'2000-08-20' AS Date), N'sasanka4@gmail.com', N'0761885935   ', 1, 1, N'123456789', CAST(N'2023-11-02T21:21:25.033' AS DateTime), 2)
INSERT [dbo].[tblUser] ([UserId], [UserName], [FirstName], [LastName], [DOB], [Email], [MobileNumber], [UserLevel], [Active], [Password], [CreatedDate], [AssignedTicketSequnceGroup]) VALUES (6, N'Manager1', N'Assistent', N'Manager', CAST(N'2023-08-30' AS Date), N'sasanka5@gmail.com', N'0761885936   ', 2, 1, N'123456789', CAST(N'2023-11-02T07:07:11.127' AS DateTime), 3)
INSERT [dbo].[tblUser] ([UserId], [UserName], [FirstName], [LastName], [DOB], [Email], [MobileNumber], [UserLevel], [Active], [Password], [CreatedDate], [AssignedTicketSequnceGroup]) VALUES (7, N'Manager2', N'Assistnent', N'Manager', CAST(N'2000-01-04' AS Date), N'assiistentmanager@gmail.com', N'0764513254   ', 2, 1, N'123456789', CAST(N'2024-02-16T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[tblUser] ([UserId], [UserName], [FirstName], [LastName], [DOB], [Email], [MobileNumber], [UserLevel], [Active], [Password], [CreatedDate], [AssignedTicketSequnceGroup]) VALUES (8, N'Manager3', N'Assistent', N'Manager', CAST(N'2000-07-31' AS Date), N'manager3@gmail.com', N'0761245369   ', 2, 1, N'123456789', CAST(N'2024-02-18T20:37:38.430' AS DateTime), NULL)
INSERT [dbo].[tblUser] ([UserId], [UserName], [FirstName], [LastName], [DOB], [Email], [MobileNumber], [UserLevel], [Active], [Password], [CreatedDate], [AssignedTicketSequnceGroup]) VALUES (9, N'Manager4', N'Manager4', N'Assisstnent', CAST(N'2024-03-15' AS Date), N'Manager4@gmail.com', N'0764512545   ', NULL, 1, N'123456789', CAST(N'2024-03-02T23:49:01.423' AS DateTime), NULL)
INSERT [dbo].[tblUser] ([UserId], [UserName], [FirstName], [LastName], [DOB], [Email], [MobileNumber], [UserLevel], [Active], [Password], [CreatedDate], [AssignedTicketSequnceGroup]) VALUES (10, N'Manager5', N'Assistent', N'Manager5', CAST(N'1990-04-02' AS Date), N'manager5@gmail.com', N'0761245369   ', 2, 1, N'123456789', CAST(N'2024-03-03T12:49:45.943' AS DateTime), NULL)
INSERT [dbo].[tblUser] ([UserId], [UserName], [FirstName], [LastName], [DOB], [Email], [MobileNumber], [UserLevel], [Active], [Password], [CreatedDate], [AssignedTicketSequnceGroup]) VALUES (11, N'Coordinator2', N'Tiket', N'Coordinator2', CAST(N'1998-05-04' AS Date), N'coordinator2@gamil.com', N'0761245645   ', 3, 1, N'123456789', CAST(N'2024-03-03T19:49:46.660' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[tblUser] OFF
GO
SET IDENTITY_INSERT [dbo].[tblUserlLevel] ON 

INSERT [dbo].[tblUserlLevel] ([UserlevelID], [UserLevel], [CreateDate], [Active]) VALUES (1, N'Admin', CAST(N'2023-10-28T20:44:49.280' AS DateTime), 1)
INSERT [dbo].[tblUserlLevel] ([UserlevelID], [UserLevel], [CreateDate], [Active]) VALUES (2, N'Manager', CAST(N'2024-02-18T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[tblUserlLevel] ([UserlevelID], [UserLevel], [CreateDate], [Active]) VALUES (3, N'Ticket Coordinator', CAST(N'2024-02-18T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[tblUserlLevel] ([UserlevelID], [UserLevel], [CreateDate], [Active]) VALUES (4, N'Ticket Handler', CAST(N'2024-02-18T00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[tblUserlLevel] OFF
GO
SET IDENTITY_INSERT [dbo].[tblWarrentyExtendedDate] ON 

INSERT [dbo].[tblWarrentyExtendedDate] ([weId], [mWarrentyId], [expiredDate], [IsExpired], [IsWarrentyExtended], [warrentyExtendedFromDate], [warrentyExtendedToDate], [Active], [createddate]) VALUES (1, 8, CAST(N'2024-01-25T00:00:00.000' AS DateTime), NULL, 1, CAST(N'2024-02-06T14:27:07.063' AS DateTime), CAST(N'2026-02-06T00:00:00.000' AS DateTime), 1, CAST(N'2024-02-06T14:27:07.063' AS DateTime))
INSERT [dbo].[tblWarrentyExtendedDate] ([weId], [mWarrentyId], [expiredDate], [IsExpired], [IsWarrentyExtended], [warrentyExtendedFromDate], [warrentyExtendedToDate], [Active], [createddate]) VALUES (2, 8, CAST(N'2024-01-25T00:00:00.000' AS DateTime), NULL, 1, CAST(N'2024-02-07T13:23:41.813' AS DateTime), CAST(N'2026-02-07T00:00:00.000' AS DateTime), 1, CAST(N'2024-02-07T13:23:41.813' AS DateTime))
INSERT [dbo].[tblWarrentyExtendedDate] ([weId], [mWarrentyId], [expiredDate], [IsExpired], [IsWarrentyExtended], [warrentyExtendedFromDate], [warrentyExtendedToDate], [Active], [createddate]) VALUES (3, 8, CAST(N'2024-01-01T00:00:00.000' AS DateTime), NULL, 1, CAST(N'2024-02-07T13:46:14.927' AS DateTime), CAST(N'2026-02-07T00:00:00.000' AS DateTime), 1, CAST(N'2024-02-07T13:46:14.927' AS DateTime))
SET IDENTITY_INSERT [dbo].[tblWarrentyExtendedDate] OFF
GO
SET IDENTITY_INSERT [dbo].[tblWarrentyhistory] ON 

INSERT [dbo].[tblWarrentyhistory] ([whId], [mWarrentyId], [comment], [createdDate], [Active]) VALUES (1, 8, N'Warrenty Started from 2024-01-30 07:57:17 to 2026-01-30.', CAST(N'2024-01-30T07:57:17.717' AS DateTime), 1)
INSERT [dbo].[tblWarrentyhistory] ([whId], [mWarrentyId], [comment], [createdDate], [Active]) VALUES (2, 8, N'Warrenty Extended', CAST(N'2024-02-06T14:27:07.037' AS DateTime), 1)
INSERT [dbo].[tblWarrentyhistory] ([whId], [mWarrentyId], [comment], [createdDate], [Active]) VALUES (3, 8, N'Warrenty Extended', CAST(N'2024-02-07T13:23:41.810' AS DateTime), 1)
INSERT [dbo].[tblWarrentyhistory] ([whId], [mWarrentyId], [comment], [createdDate], [Active]) VALUES (4, 8, N'Warrenty Extended', CAST(N'2024-02-07T13:46:14.927' AS DateTime), 1)
INSERT [dbo].[tblWarrentyhistory] ([whId], [mWarrentyId], [comment], [createdDate], [Active]) VALUES (5, 9, N'Warrenty Started from 2024-02-09 10:56:05 to 2026-02-09.', CAST(N'2024-02-09T10:56:05.947' AS DateTime), 1)
INSERT [dbo].[tblWarrentyhistory] ([whId], [mWarrentyId], [comment], [createdDate], [Active]) VALUES (6, 10, N'Warrenty Started from 2024-02-09 14:58:51 to 2026-02-09.', CAST(N'2024-02-09T14:58:51.447' AS DateTime), 1)
INSERT [dbo].[tblWarrentyhistory] ([whId], [mWarrentyId], [comment], [createdDate], [Active]) VALUES (7, 11, N'Warrenty Started from 2024-02-09 15:14:46 to 2026-02-09.', CAST(N'2024-02-09T15:14:46.930' AS DateTime), 1)
INSERT [dbo].[tblWarrentyhistory] ([whId], [mWarrentyId], [comment], [createdDate], [Active]) VALUES (8, 12, N'Warrenty Started from 2024-02-11 20:16:35 to 2026-02-11.', CAST(N'2024-02-11T20:16:35.943' AS DateTime), 1)
INSERT [dbo].[tblWarrentyhistory] ([whId], [mWarrentyId], [comment], [createdDate], [Active]) VALUES (9, 13, N'Warrenty Started from 2024-02-12 21:05:41 to 2026-02-12.', CAST(N'2024-02-12T21:05:41.637' AS DateTime), 1)
INSERT [dbo].[tblWarrentyhistory] ([whId], [mWarrentyId], [comment], [createdDate], [Active]) VALUES (10, 14, N'Warrenty Started from 2024-02-16 18:55:48 to 2027-02-16.', CAST(N'2024-02-16T18:55:48.753' AS DateTime), 1)
INSERT [dbo].[tblWarrentyhistory] ([whId], [mWarrentyId], [comment], [createdDate], [Active]) VALUES (11, 15, N'Warrenty Started from 2024-02-17 00:06:05 to 2026-02-17.', CAST(N'2024-02-17T00:06:05.160' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[tblWarrentyhistory] OFF
GO
ALTER TABLE [dbo].[tblInventoryData]  WITH CHECK ADD  CONSTRAINT [FK_tblInventoryData_tblMasterStore] FOREIGN KEY([MasterId])
REFERENCES [dbo].[tblMasterStore] ([mStoreId])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tblInventoryData] CHECK CONSTRAINT [FK_tblInventoryData_tblMasterStore]
GO
ALTER TABLE [dbo].[tblInventoryHistory]  WITH CHECK ADD  CONSTRAINT [FK_tblInventoryHistory_tblInventoryData] FOREIGN KEY([inventoryId])
REFERENCES [dbo].[tblInventoryData] ([InventoryID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tblInventoryHistory] CHECK CONSTRAINT [FK_tblInventoryHistory_tblInventoryData]
GO
ALTER TABLE [dbo].[tblInventoryHistory]  WITH CHECK ADD  CONSTRAINT [FK_tblInventoryHistory_tblUser] FOREIGN KEY([createdby])
REFERENCES [dbo].[tblUser] ([UserId])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tblInventoryHistory] CHECK CONSTRAINT [FK_tblInventoryHistory_tblUser]
GO
ALTER TABLE [dbo].[tblMasterStore]  WITH CHECK ADD  CONSTRAINT [FK_tblMasterStore_tblProductCategories] FOREIGN KEY([ProductId])
REFERENCES [dbo].[tblProductCategories] ([ProductID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tblMasterStore] CHECK CONSTRAINT [FK_tblMasterStore_tblProductCategories]
GO
ALTER TABLE [dbo].[tblMasterTicketDetails]  WITH CHECK ADD  CONSTRAINT [FK_tblMasterTicketDetails_tblTicket] FOREIGN KEY([TicketID])
REFERENCES [dbo].[tblTicket] ([TicketId])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tblMasterTicketDetails] CHECK CONSTRAINT [FK_tblMasterTicketDetails_tblTicket]
GO
ALTER TABLE [dbo].[tblMasterWarrenty]  WITH CHECK ADD  CONSTRAINT [FK_tblMasterWarrenty_tblInventoryData] FOREIGN KEY([inventoryId])
REFERENCES [dbo].[tblInventoryData] ([InventoryID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tblMasterWarrenty] CHECK CONSTRAINT [FK_tblMasterWarrenty_tblInventoryData]
GO
ALTER TABLE [dbo].[tblSalesDetails]  WITH CHECK ADD  CONSTRAINT [FK_tblSalesDetails_tblCoustomerDetails] FOREIGN KEY([CoustomerId])
REFERENCES [dbo].[tblCoustomerDetails] ([CoustomerId])
GO
ALTER TABLE [dbo].[tblSalesDetails] CHECK CONSTRAINT [FK_tblSalesDetails_tblCoustomerDetails]
GO
ALTER TABLE [dbo].[tblSalesDetails]  WITH CHECK ADD  CONSTRAINT [FK_tblSalesDetails_tblInventoryData] FOREIGN KEY([InventoryId])
REFERENCES [dbo].[tblInventoryData] ([InventoryID])
GO
ALTER TABLE [dbo].[tblSalesDetails] CHECK CONSTRAINT [FK_tblSalesDetails_tblInventoryData]
GO
ALTER TABLE [dbo].[tblTicket]  WITH CHECK ADD  CONSTRAINT [FK_tblTicket_tblCoustomerDetails] FOREIGN KEY([CoustomerId])
REFERENCES [dbo].[tblCoustomerDetails] ([CoustomerId])
GO
ALTER TABLE [dbo].[tblTicket] CHECK CONSTRAINT [FK_tblTicket_tblCoustomerDetails]
GO
ALTER TABLE [dbo].[tblTicket]  WITH CHECK ADD  CONSTRAINT [FK_tblTicket_tblInventoryData] FOREIGN KEY([InventoryID])
REFERENCES [dbo].[tblInventoryData] ([InventoryID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tblTicket] CHECK CONSTRAINT [FK_tblTicket_tblInventoryData]
GO
ALTER TABLE [dbo].[tblTicketComment]  WITH CHECK ADD  CONSTRAINT [FK_tblTicketComment_tblMasterTicketDetails] FOREIGN KEY([TicketID])
REFERENCES [dbo].[tblTicket] ([TicketId])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tblTicketComment] CHECK CONSTRAINT [FK_tblTicketComment_tblMasterTicketDetails]
GO
ALTER TABLE [dbo].[tblTicketProjectDtl]  WITH CHECK ADD  CONSTRAINT [FK_tblTicketProjectDtl_tblTicket] FOREIGN KEY([TicketId])
REFERENCES [dbo].[tblTicket] ([TicketId])
GO
ALTER TABLE [dbo].[tblTicketProjectDtl] CHECK CONSTRAINT [FK_tblTicketProjectDtl_tblTicket]
GO
ALTER TABLE [dbo].[tblTicketStatus]  WITH CHECK ADD  CONSTRAINT [FK_tblTicketStatus_tblTicketStatus] FOREIGN KEY([TicketStatusId])
REFERENCES [dbo].[tblTicketStatus] ([TicketStatusId])
GO
ALTER TABLE [dbo].[tblTicketStatus] CHECK CONSTRAINT [FK_tblTicketStatus_tblTicketStatus]
GO
ALTER TABLE [dbo].[tblTicketTaskAssign]  WITH CHECK ADD  CONSTRAINT [FK_tblTicketTaskAssign_tblTicketProjectDtl] FOREIGN KEY([ticketProjectId])
REFERENCES [dbo].[tblTicketProjectDtl] ([TicketProjectId])
GO
ALTER TABLE [dbo].[tblTicketTaskAssign] CHECK CONSTRAINT [FK_tblTicketTaskAssign_tblTicketProjectDtl]
GO
ALTER TABLE [dbo].[tblTicketTaskAssign]  WITH CHECK ADD  CONSTRAINT [FK_tblTicketTaskAssign_tblTicketStatus] FOREIGN KEY([StatustId])
REFERENCES [dbo].[tblTicketStatus] ([TicketStatusId])
GO
ALTER TABLE [dbo].[tblTicketTaskAssign] CHECK CONSTRAINT [FK_tblTicketTaskAssign_tblTicketStatus]
GO
ALTER TABLE [dbo].[tblTicketTaskAssign]  WITH CHECK ADD  CONSTRAINT [FK_tblTicketTaskAssign_tblUser] FOREIGN KEY([AssignedTo])
REFERENCES [dbo].[tblUser] ([UserId])
GO
ALTER TABLE [dbo].[tblTicketTaskAssign] CHECK CONSTRAINT [FK_tblTicketTaskAssign_tblUser]
GO
ALTER TABLE [dbo].[tblTicketTaskAssign]  WITH CHECK ADD  CONSTRAINT [FK_tblTicketTaskAssign_tblUser1] FOREIGN KEY([AssignedFrom])
REFERENCES [dbo].[tblUser] ([UserId])
GO
ALTER TABLE [dbo].[tblTicketTaskAssign] CHECK CONSTRAINT [FK_tblTicketTaskAssign_tblUser1]
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD  CONSTRAINT [FK_tblUser_tblMasterTicketSequnces] FOREIGN KEY([AssignedTicketSequnceGroup])
REFERENCES [dbo].[tblMasterTicketSequnces] ([SequanceIndexID])
GO
ALTER TABLE [dbo].[tblUser] CHECK CONSTRAINT [FK_tblUser_tblMasterTicketSequnces]
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD  CONSTRAINT [FK_tblUser_tblUserlLevel] FOREIGN KEY([UserLevel])
REFERENCES [dbo].[tblUserlLevel] ([UserlevelID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tblUser] CHECK CONSTRAINT [FK_tblUser_tblUserlLevel]
GO
ALTER TABLE [dbo].[tblWarrentyExtendedDate]  WITH CHECK ADD  CONSTRAINT [FK_tblWarrentyExtendedDate_tblMasterWarrenty] FOREIGN KEY([mWarrentyId])
REFERENCES [dbo].[tblMasterWarrenty] ([mWarrentyId])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tblWarrentyExtendedDate] CHECK CONSTRAINT [FK_tblWarrentyExtendedDate_tblMasterWarrenty]
GO
ALTER TABLE [dbo].[tblWarrentyhistory]  WITH CHECK ADD  CONSTRAINT [FK_tblWarrentyhistory_tblMasterWarrenty] FOREIGN KEY([mWarrentyId])
REFERENCES [dbo].[tblMasterWarrenty] ([mWarrentyId])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tblWarrentyhistory] CHECK CONSTRAINT [FK_tblWarrentyhistory_tblMasterWarrenty]
GO
/****** Object:  StoredProcedure [dbo].[sp_AddTicket]    Script Date: 13/03/2024 10:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sasanka Buddhi 
-- Create date: 2024-02-12
-- Description:	sp for add tickets
-- =============================================
CREATE PROCEDURE [dbo].[sp_AddTicket] (@@SerialNumber NVARCHAR(MAX), @@TicketRemark NVARCHAR(MAX))
AS
DECLARE @@CustomerID AS INT, @@InventoryID AS INT , @@ScoupIdentityID AS INT;

BEGIN
	SET NOCOUNT ON;

	SELECT @@InventoryID = a.InventoryID ,@@CustomerID = c.CoustomerId FROM [ProjectDB].[dbo].[tblInventoryData] a
	JOIN [ProjectDB].[dbo].[tblSalesDetails] b ON a.InventoryID = b.InventoryId
	JOIN [ProjectDB].[dbo].[tblCoustomerDetails] c ON b.CoustomerId = c.CoustomerId
	WHERE a.SerialNumber = @@SerialNumber

	INSERT INTO [tblTicket] (InventoryID,CoustomerId,TicketDiscription,CreatedDate)
	VALUES (@@InventoryID,@@CustomerID,@@TicketRemark,GETDATE());
	SET @@ScoupIdentityID = SCOPE_IDENTITY();
	
	IF (@@ScoupIdentityID IS NOT NULL)
	BEGIN
		SELECT 1;
	END ELSE
	BEGIN
		SELECT 0;
	END
  
END
GO
/****** Object:  StoredProcedure [dbo].[sp_AssignTicket]    Script Date: 13/03/2024 10:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sasanka Buddhi
-- Create date: 2024 02 08
-- Description:	sp for insert Ticket
--  exec  sp_AssignTicket 5,4,3
-- =============================================
CREATE PROCEDURE [dbo].[sp_AssignTicket](@@TicketID INT, @@AssignedTo INT, @@UserID INT)
AS
DECLARE @@ISopen AS BIT, @@TicketProjectDtlId AS INT;

BEGIN
	SET NOCOUNT ON;

	IF(@@TicketID IS NOT NULL AND @@AssignedTo IS NOT NULL AND @@UserID IS NOT NULL OR @@UserID != 0)
	BEGIN

		SELECT @@ISopen =  IsOpen  FROM [ProjectDB].[dbo].[tblTicket] WHERE TicketId = @@TicketID
		IF ( @@ISopen IS NULL OR  @@ISopen = 0)
		BEGIN 
			--Implement from this
			UPDATE [ProjectDB].[dbo].[tblTicket] SET IsOpen=1,OpenedDate=GETDATE()  WHERE TicketId = @@TicketID;


			INSERT INTO [ProjectDB].[dbo].[tblTicketProjectDtl] ([TicketId],[CurrentSeqence],[Active],[CreateDate])
			VALUES (@@TicketID,(SELECT TOP 1 SequanceIndexID FROM [ProjectDB].[dbo].[tblMasterTicketSequnces] ORDER BY SequanceIndexID)+1,1,GETDATE());
			SET @@TicketProjectDtlId = SCOPE_IDENTITY();
			--SELECT @@TicketProjectDtlId

				IF (@@TicketProjectDtlId IS NOT NULL)
				BEGIN
					INSERT INTO [ProjectDB].[dbo].[tblTicketTaskAssign] ([ticketProjectId],[AssignedFrom],[AssignedTo],[AssignedDate],[Active],[StatustId])
					VALUES (@@TicketProjectDtlId,@@UserID,@@AssignedTo,GETDATE(),1,1);

					  	  INSERT INTO [ProjectDB].[dbo].[tblTicketComment] (TicketID,[Comment],[CommentedDate],[CommentedBy])
					  VALUES (@@TicketID,'Ticket Open and Assigned From '+(SELECT UserName FROM [ProjectDB].[dbo].[tblUser] WHERE UserId = @@UserID)
					  +' To '+(SELECT UserName FROM [ProjectDB].[dbo].[tblUser] WHERE UserId = @@AssignedTo)+'',GETDATE(),@@UserID)

					SELECT 1;
				END ELSE
				BEGIN
					SELECT 0;
				END
		END

		ELSE
		BEGIN
			SELECT 0;
		END
	END
	ELSE
	BEGIN
		SELECT 0
	END



END
GO
/****** Object:  StoredProcedure [dbo].[sp_CheckExpierdWarrenty]    Script Date: 13/03/2024 10:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Sasanka Buddhi
-- Create date: 2024/01/25
-- Description:	sp for check day to day warrenty
-- =============================================
CREATE PROCEDURE [dbo].[sp_CheckExpierdWarrenty]
AS

BEGIN
	SET NOCOUNT ON;

	

	UPDATE tblWarrentyExtendedDate SET [Active] = 0, IsExpired = 0
	where mWarrentyId IN (SELECT mWarrentyId FROM [ProjectDB].[dbo].[tblMasterWarrenty] WHERE [IsExpiered] = 1)
	AND  CONVERT(DATE, warrentyExtendedToDate) = CONVERT(DATE, GETDATE());

	UPDATE tblMasterWarrenty set [IsExpiered] = 1, Active = 0 WHERE CONVERT(DATE, WarrentyExpierdDate) = CONVERT(DATE, GETDATE());


END

GO
/****** Object:  StoredProcedure [dbo].[sp_ExtendWarrenty]    Script Date: 13/03/2024 10:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sasanka Buddhi 
-- Create date: 2024 02 05
-- Description:	sp for warrenty exend 
-- =============================================
CREATE PROCEDURE [dbo].[sp_ExtendWarrenty] (@@SerialNumber NVARCHAR(MAX),@@WarrentyMonths INT, @@ExtendCost DECIMAL(18,2))
AS
DECLARE @@MasterWarrentyID AS INT, @@CustomerId AS INT, @@InventoryID AS INT, @@ExpiredDate AS DATE , @@ExtendToDate AS DATE,@@ReminderDate AS DATETIME, @@SCOPEID AS INT;

BEGIN
	SET NOCOUNT ON;
	SELECT  @@InventoryID = a.inventoryId , @@MasterWarrentyID = b.mWarrentyId, @@CustomerId = d.CoustomerId,
	@@ExpiredDate = b.WarrentyExpierdDate
	from [ProjectDB].[dbo].[tblInventoryData] a
	join [ProjectDB].[dbo].[tblMasterWarrenty] b on a.InventoryID = b.inventoryId
	join [ProjectDB].[dbo].[tblSalesDetails] c on a.InventoryID = c.InventoryId
	join [ProjectDB].[dbo].[tblCoustomerDetails] d on c.CoustomerId = d.CoustomerId
	where a.SerialNumber like '%'+@@SerialNumber+'%'

		SET @@ExtendToDate = DATEADD(MONTH, @@WarrentyMonths, GETDATE()); --Expierd date
			SET @@ReminderDate = DATEADD(DAY, -7, @@ExtendToDate);

	--update [ProjectDB].[dbo].[tblMasterWarrenty] set WarrentyExpierdDate =  @@ExtendToDate where mWarrentyId =@@MasterWarrentyID; 
	
	UPDATE [ProjectDB].[dbo].[tblMasterWarrenty] SET WarrentyExpierdDate = @@ExtendToDate,@@ReminderDate = @@ReminderDate, IsExtended = 1, Active = 1
	where mWarrentyId =@@MasterWarrentyID;

	INSERT INTO [ProjectDB].[dbo].[tblWarrentyhistory] (mWarrentyId,comment,createdDate,Active)
	values (@@MasterWarrentyID, 'Warrenty Extended',GETDATE(),1)

	INSERT INTO  [ProjectDB].[dbo].[tblSalesDetails] (InventoryId,CoustomerId,ExtendPrice,CreatedDate)
	VALUES (@@InventoryID,@@CustomerId,@@ExtendCost,GETDATE())



	INSERT INTO [ProjectDB].[dbo].[tblWarrentyExtendedDate] ([mWarrentyId],[expiredDate],[IsWarrentyExtended]
    ,[warrentyExtendedFromDate],[warrentyExtendedToDate],[Active],[createddate])
	VALUES (@@MasterWarrentyID, @@ExpiredDate,1,GETDATE(),@@ExtendToDate,1,GETDATE())
	SET @@SCOPEID =  SCOPE_IDENTITY();

	IF (@@SCOPEID IS NOT NULL)
	BEGIN
		SELECT 1
	END ELSE
	BEGIN
		SELECT 0
	END

END

GO
/****** Object:  StoredProcedure [dbo].[sp_Get_SaleItem_data]    Script Date: 13/03/2024 10:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sasanka Buddhi
-- Create date: 2024-01-23
-- Description:	spFor get SoldItem Data
 
 --- EXEC sp_Get_SaleItem_data null,null,'0768875415'  
-- =============================================
CREATE PROCEDURE [dbo].[sp_Get_SaleItem_data] (@@SerialNumber nvarchar(max) = NULL, @@InvoiceNo NVARCHAR(MAX) = NULL, @@CcontactNo NVARCHAR(13) = NULL)
AS

--DECLARE @@NewCoustomerID AS INT , @@InventoryId AS INT;
--Declare

BEGIN
	SET NOCOUNT ON;

	SELECT a.SerialNumber, b.CreatedDate, c.CoustomerName, c.ContactNumber 
	FROM [ProjectDB].[dbo].[tblInventoryData] a
	JOIN [ProjectDB].[dbo].[tblSalesDetails] b ON a.InventoryID = b.InventoryId
	JOIN [ProjectDB].[dbo].[tblCoustomerDetails] c ON b.CoustomerId = c.CoustomerId 
	WHERE ((a.SerialNumber = @@SerialNumber) OR
		(b.InvoiceId = @@InvoiceNo) OR
		 (c.ContactNumber = @@CcontactNo));

END


--select * from tblInventoryData
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertNewWarrenty]    Script Date: 13/03/2024 10:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Sasanka Buddhi
-- Create date: 2024/01/26
-- Description:	sp for new warrenty
-- =============================================
--exec sp_InsertNewWarrenty 1038, 24
CREATE PROCEDURE [dbo].[sp_InsertNewWarrenty] (@@InventoryId INT, @@WarrentyMonth INT)
AS

DECLARE @@EXpieredDate DATE, @@ReminderDate DATE, @@NewMasWarrentyId INT;

BEGIN
	SET NOCOUNT ON;

		    SET @@EXpieredDate = DATEADD(MONTH, @@WarrentyMonth, GETDATE()); --Expierd date
			SET @@ReminderDate = DATEADD(DAY, -7, @@EXpieredDate);

			INSERT INTO [ProjectDB].[dbo].[tblMasterWarrenty]
			([inventoryId],[WarrentyStartDate],[Active],[WarrentyExpierdDate],[ExpierReminderDate],[WarrentyMonths])
			VALUES (@@InventoryId,GETDATE(),1,@@EXpieredDate,@@ReminderDate,@@WarrentyMonth)
			SET @@NewMasWarrentyId = SCOPE_IDENTITY();
	

			INSERT INTO [ProjectDB].[dbo].[tblWarrentyhistory] ([mWarrentyId], [comment], [createdDate], [Active])
			VALUES 
			(@@NewMasWarrentyId,'Warrenty Started from ' + CONVERT(NVARCHAR, GETDATE(), 120) + ' to ' + CONVERT(NVARCHAR, @@EXpieredDate, 120) + '.',
			 GETDATE(),1);


END
GO
/****** Object:  StoredProcedure [dbo].[sp_LoadTicketdetailsToManage]    Script Date: 13/03/2024 10:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sasanka Buddhi Pramodya
-- Create date: 2024-02-15
-- Description:	sp_LoadTicketdetailsToManage to get ticket history details

-- exec sp_LoadTicketdetailsToManage 5
-- =============================================
CREATE PROCEDURE [dbo].[sp_LoadTicketdetailsToManage](@@TicketID INT)
AS
DECLARE @@TempTable AS TABLE (TicketId INT, TicketDescription NVARCHAR(MAX),TicketDate DATETIME, CurrentSequnceIndex INT,CurrentSequnce NVARCHAR(100),SequnceIDList INT,SequnceNameList NVARCHAR(200), AssignDate DATETIME, AssignFrom NVARCHAR(200),TicketStatus NVARCHAR(30),SerialNumber NVARCHAR(MAX) ,
							CommentedDate DATETIME,Comment NVARCHAR(MAX),CommentedBY NVARCHAR(300), NextLevelUserId INT, NextLevelUserName NVARCHAR(300));

BEGIN
	SET NOCOUNT ON;
			INSERT INTO @@TempTable
			(TicketId, TicketDescription,TicketDate,CurrentSequnceIndex ,CurrentSequnce,AssignDate,AssignFrom,TicketStatus,SerialNumber) 

			SELECT TicketId, TicketDiscription, CreatedDate AS TicketDate,CurrentSequnceIndex, CurrentSequnce, AssignedDate AS AssignDate, AssignFrom, TicketStatus, SerialNumber
			FROM (
				SELECT a.TicketId, a.TicketDiscription, a.CreatedDate,h.SequanceIndexID as CurrentSequnceIndex, h.SequnceName AS CurrentSequnce, c.AssignedDate,
					   e.UserName AS AssignFrom, f.TicketStatus, g.SerialNumber,
					   ROW_NUMBER() OVER (PARTITION BY a.TicketId ORDER BY c.AssignedDate DESC) AS RowNum
				FROM [ProjectDB].[dbo].[tblTicket] a
				JOIN [ProjectDB].[dbo].[tblTicketProjectDtl] b ON a.TicketId = b.TicketId
				JOIN [ProjectDB].[dbo].[tblTicketTaskAssign] c ON b.TicketProjectId = c.ticketProjectId
				JOIN [ProjectDB].[dbo].[tblTicketComment] d ON a.TicketId = d.TicketID
				JOIN [ProjectDB].[dbo].[tblUser] e ON c.AssignedFrom = e.UserId
				JOIN [ProjectDB].[dbo].tblTicketStatus f ON c.StatustId = f.TicketStatusId
				JOIN [ProjectDB].[dbo].[tblInventoryData] g ON a.InventoryID = g.InventoryID
				JOIN [ProjectDB].[dbo].[tblMasterTicketSequnces] h ON b.CurrentSeqence = h.SequanceIndexID
				WHERE a.TicketId = @@TicketID
			) AS TicketCTE
			WHERE RowNum = 1;


		INSERT INTO @@TempTable (CommentedDate,Comment,CommentedBY)
		SELECT a.CommentedDate,a.Comment,b.UserName FROM [ProjectDB].[dbo].tblTicketComment a
		JOIN [ProjectDB].[dbo].[tblUser] b on a.CommentedBy = b.UserId
		WHERE a.TicketID  = @@TicketID ORDER BY a.CommentedDate DESC

		INSERT INTO @@TempTable (SequnceIDList,SequnceNameList)
		SELECT SequanceIndexID,SequnceName FROM [ProjectDB].[dbo].[tblMasterTicketSequnces]

		INSERT INTO @@TempTable (NextLevelUserId,NextLevelUserName)
		SELECT UserId,UserName FROM [ProjectDB].[dbo].[tblUser] 
		WHERE AssignedTicketSequnceGroup = (
		SELECT c.SequanceIndexID +1 FROM [ProjectDB].[dbo].[tblTicket] a
		JOIN [ProjectDB].[dbo].[tblTicketProjectDtl] b on a.TicketId = b.TicketId
		JOIN [ProjectDB].[dbo].[tblMasterTicketSequnces] c on b.CurrentSeqence = c.SequanceIndexID
		WHERE a.TicketId = @@TicketID)


	SELECT * FROM @@TempTable

END
GO
/****** Object:  StoredProcedure [dbo].[sp_LogadPendingTickets]    Script Date: 13/03/2024 10:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sasanka Buddhi	
-- Create date: 2024-02-15
-- Description:	sp for get Pending Tickets
--  exec [ProjectDB].[dbo].[sp_LogadPendingTickets] 5
-- =============================================
CREATE PROCEDURE [dbo].[sp_LogadPendingTickets] (@@UserID INT)
AS
 
DECLARE @@TempTable AS TABLE (TicketID INT, TicketDescription NVARCHAR(MAX), AssignDate DATETIME,CurrentStatus NVARCHAR(30))
BEGIN
	SET NOCOUNT ON;
	INSERT INTO @@TempTable (TicketID,TicketDescription,AssignDate,CurrentStatus)
	select a.TicketId,a.TicketDiscription, c.AssignedDate,e.TicketStatus from
	[ProjectDB].[dbo].[tblTicket] a 
	JOIN [ProjectDB].[dbo].[tblTicketProjectDtl] b on a.TicketId = b.TicketId
	JOIN [ProjectDB].[dbo].[tblTicketTaskAssign] c on b.TicketProjectId = c.ticketProjectId
	JOIN [ProjectDB].[dbo].[tblUser] d on c.AssignedTo = d.UserId
	JOIn [ProjectDB].[dbo].[tblTicketStatus] e on c.StatustId = e.TicketStatusId
	WHERE c.Active  =  1 and  c.AssignedTo = @@UserID

	SELECT * FROM @@TempTable

END
GO
/****** Object:  StoredProcedure [dbo].[sp_ManageTicketLevelToLevel]    Script Date: 13/03/2024 10:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sasanka Buddhi
-- Create date: 2024 02 08
-- Description:	sp for manage Ticket by levels

-- exec sp_ManageTicketLevelToLevel 5,2,null
-- exec sp_ManageTicketLevelToLevel 17,3,6
-- exec sp_ManageTicketLevelToLevel 5,2,null
-- exec sp_ManageTicketLevelToLevel 5,3,null

-- exec sp_ManageTicketLevelToLevel 1,2,1
-- =============================================
CREATE PROCEDURE [dbo].[sp_ManageTicketLevelToLevel] (@@TicketID INT, @@StatusID INT, @@AssignedTo INT = NULL)
AS
DECLARE @@CurrentSequence AS INT , @@TaskAssignId AS INT,@@TicketPeojectId AS INT, @@PreviousUser AS INT;

BEGIN
	SET NOCOUNT ON;

	SELECT @@TicketPeojectId = b.TicketProjectId ,@@CurrentSequence=b.CurrentSeqence FROM [ProjectDB].[dbo].[tblTicket] a 
	JOIN [ProjectDB].[dbo].[tblTicketProjectDtl] b ON a.TicketId = b.TicketId 

	SELECT @@TaskAssignId=c.TaslAssignId,@@PreviousUser=c.AssignedTo
	FROM [ProjectDB].[dbo].[tblTicket] a
	JOIN  [ProjectDB].[dbo].[tblTicketProjectDtl] b on a.TicketId = b.TicketId
	JOIN [ProjectDB].[dbo].[tblTicketTaskAssign] c on b.TicketProjectId = c.ticketProjectId
	WHERE  a.TicketId =  @@TicketID and c.Active = 1;


	IF (@@StatusID = 2)  --Accepet
	BEGIN
		UPDATE [ProjectDB].[dbo].[tblTicketTaskAssign] SET StatustId =  2 WHERE TaslAssignId = @@TaskAssignId and Active = 1;
				 
				 INSERT INTO [ProjectDB].[dbo].[tblTicketComment] ([TicketID],[Comment],[CommentedDate],[CommentedBy])
				  VALUES (@@TicketID,'Ticket Accepted by ' + (SELECT UserName FROM [ProjectDB].[dbo].[tblUser] where UserId=@@PreviousUser)+' ',GETDATE(),@@PreviousUser)

		SELECT 2;


		--Inset Comment Part
	END
	IF (@@StatusID = 3) --Submit
	BEGIN
		
		IF (@@CurrentSequence = 3) 
		BEGIN
			UPDATE [ProjectDB].[dbo].[tblTicketProjectDtl] SET Active = 0
			WHERE TicketId = @@TicketID

			UPDATE  [ProjectDB].[dbo].[tblTicketTaskAssign] SET Active =0,
			StatustId = 5 WHERE TaslAssignId = @@TaskAssignId;
			SELECT 5;

			UPDATE [ProjectDB].[dbo].[tblTicket] SET IsClosed = 1, ClosedDate = GETDATE();

			INSERT INTO [ProjectDB].[dbo].[tblTicketComment] ([TicketID],[Comment],[CommentedDate],[CommentedBy])
			VALUES (@@TicketID,'Ticket Closed by ' + (SELECT UserName FROM [ProjectDB].[dbo].[tblUser] where UserId=@@PreviousUser)+' ',GETDATE(),@@PreviousUser)

			--Insert Comment
		END 
		ELSE BEGIN
			UPDATE [ProjectDB].[dbo].[tblTicketProjectDtl] SET CurrentSeqence = @@CurrentSequence+1 
			WHERE TicketId = @@TicketID

			UPDATE  [ProjectDB].[dbo].[tblTicketTaskAssign] SET Active =0,
			StatustId = 3 WHERE TaslAssignId = @@TaskAssignId;

			INSERT INTO [ProjectDB].[dbo].[tblTicketTaskAssign] ([ticketProjectId],[AssignedFrom],[AssignedTo],[AssignedDate],[Active],[StatustId])
			VALUES (@@TicketPeojectId,@@PreviousUser,@@AssignedTo,GETDATE(),1,1)

			INSERT INTO [ProjectDB].[dbo].[tblTicketComment] ([TicketID],[Comment],[CommentedDate],[CommentedBy])
			VALUES (@@TicketID,'Ticket Submitted by ' + (SELECT UserName FROM [ProjectDB].[dbo].[tblUser] where UserId=@@PreviousUser)+' ',GETDATE(),@@PreviousUser)

			--Insert Comment
			SELECT 3;
		END

	END 
	IF (@@StatusID = 4)
	BEGIN 
		UPDATE [ProjectDB].[dbo].[tblTicketProjectDtl] SET 
		CurrentSeqence = (@@CurrentSequence-1)
		WHERE TicketId = @@TicketID

		UPDATE  [ProjectDB].[dbo].[tblTicketTaskAssign] SET Active =0, StatustId = 4 WHERE TaslAssignId = @@TaskAssignId;

		SELECT TOP 1 @@AssignedTo=c.AssignedFrom ,@@PreviousUser = c.AssignedTo
		FROM [ProjectDB].[dbo].[tblTicket] a
		JOIN  [ProjectDB].[dbo].[tblTicketProjectDtl] b on a.TicketId = b.TicketId
		JOIN [ProjectDB].[dbo].[tblTicketTaskAssign] c on b.TicketProjectId = c.ticketProjectId
		WHERE  a.TicketId =  @@TicketID and c.Active = 0 ORDER BY c.AssignedDate DESC;

		INSERT INTO [ProjectDB].[dbo].[tblTicketTaskAssign] ([ticketProjectId],[AssignedFrom],[AssignedTo],[AssignedDate],[Active],[StatustId])
		VALUES (@@TicketPeojectId,@@PreviousUser,@@AssignedTo,GETDATE(),1,1)

			INSERT INTO [ProjectDB].[dbo].[tblTicketComment] ([TicketID],[Comment],[CommentedDate],[CommentedBy])
			VALUES (@@TicketID,'Ticket Rejected by ' + (SELECT UserName FROM [ProjectDB].[dbo].[tblUser] where UserId= @@PreviousUser)+' ',GETDATE(),@@PreviousUser)


		select 4;
		--Insert Comment
	END


END
GO
/****** Object:  StoredProcedure [dbo].[sp_ManageWareHouse]    Script Date: 13/03/2024 10:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Sasanka Buddhi
-- Create date: 2023 12 30
-- Description:	sp for Manage WareHouse
-- =============================================
--  EXEC [dbo].[sp_ManageWareHouse] 2,6,'asfdafasss'

CREATE PROCEDURE [dbo].[sp_ManageWareHouse] 
    @dataType int,
    @ProductCategory int,
    --@MasterStore int,
    @SerialNo NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @InsertedId INT;
	DECLARE @ReturnMessage NVARCHAR(MAX);
	Declare @MasterStorePercesedCount INT, @InventoryDataCount INT , @InventoryIn INT , @InventoryOut INT;

	DECLARE @TempTable AS TABLE (ProductCategoryId INT,[MasterId] INT,[SerialNumber] NVARCHAR(MAX),[ToTheStore] BIT,[ToTheOutside] BIT,[InsertedDate] DATETIME NULL,[OutedDateFromStore] DATETIME NULL)
	--start

	--Check


		

	SET @MasterStorePercesedCount = (SELECT b.perchesedCount FROM [ProjectDB].[dbo].[tblProductCategories] a 
	JOIN [ProjectDB].[dbo].[tblMasterStore] b ON a.ProductID = b.ProductId where a.ProductID = @ProductCategory);

	
	SET @InventoryIn = (		SELECT count(c.ToTheStore) FROM [ProjectDB].[dbo].[tblMasterStore] b JOIN
	[ProjectDB].[dbo].[tblInventoryData] c on b.mStoreId = c.MasterId where c.ToTheStore = 1
	and b.ProductId = @ProductCategory )

	SET @InventoryOut	=(SELECT count(c.ToTheOutside) FROM [ProjectDB].[dbo].[tblMasterStore] b JOIN
	[ProjectDB].[dbo].[tblInventoryData] c on b.mStoreId = c.MasterId where c.ToTheOutside = 1
	and b.ProductId = @ProductCategory)
	
	---Select @MasterStorePercesedCount, @InventoryIn,@InventoryOut
	--end
	IF(@MasterStorePercesedCount >= (@InventoryIn+@InventoryOut))
	BEGIN

	
        INSERT INTO [ProjectDB].[dbo].[tblInventoryData] 
        ([ProductCategoryId],[MasterId],[SerialNumber],[ToTheStore],[ToTheOutside],[InsertedDate],[OutedDateFromStore])
        VALUES 
        (@ProductCategory, (SELECT b.mStoreId 
		FROM tblProductCategories a
		JOIN tblMasterStore b on a.ProductID = b.ProductId
		where a.ProductID = @ProductCategory),
		@SerialNo,CASE WHEN @dataType = 1 THEN 1 ELSE 0 END,CASE WHEN @dataType = 2 THEN 1 ELSE 0 END, CASE WHEN @dataType = 1 THEN GETDATE() ELSE NULL END, 
         CASE WHEN @dataType = 2 THEN GETDATE() ELSE NULL END);
       
		SELECT  'Successfully Inserted !!!' AS  RESULT;

	END
	ELSE
	BEGIN
	SELECT 'Master Stock is Over!!!' AS RESULT;
	END




END
GO
/****** Object:  StoredProcedure [dbo].[sp_SaleItem]    Script Date: 13/03/2024 10:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Sasanka Buddhi
-- Create date: 2024-01-15
-- Description:	spForSaleItem
--- EXEC sp_SaleItem 'buddhika perera','0768875415','sasankabudsadddhi@gmail.com','59/4 horana mabiliyakanda','123456789','fds4s65f4s', 1000,5000,24

-- =============================================
CREATE PROCEDURE [dbo].[sp_SaleItem] (@@cName nvarchar(max),@@cContact nvarchar(15), 
@@cEmail nvarchar(200),@@cAddress nvarchar(max),@@Password nvarchar(max), 
@@SerialNo nvarchar(max),@@Discount decimal(18,2),@@Price decimal(18,2),@@Warrenty int)

AS

DECLARE @@NewCoustomerID AS INT , @@InventoryId AS INT;
--Declare
BEGIN
	SET NOCOUNT ON;
		SET @@InventoryId = (SELECT top 1 InventoryID FROM [dbo].[tblInventoryData] WHERE SerialNumber = @@SerialNo order by InsertedDate desc);

		
		
		IF(@@InventoryId IS NOT NULL)
		BEGIN
			-- Coustomer Registration
		INSERT INTO [ProjectDB].[dbo].[tblCoustomerDetails]  ([CoustomerName], [Address], [Email], [ContactNumber], [UserName], [Password], [Active],CreatedDate)
		VALUES (@@cName,@@cAddress,@@cEmail,@@cContact,SUBSTRING(@@cName, 1, CHARINDEX(' ', @@cName) - 1),@@Password,1,GETDATE());
		SET @@NewCoustomerID = SCOPE_IDENTITY();
	
		
		-- SaleDetails 
		INSERT INTO[ProjectDB].[dbo].[tblSalesDetails] ([InventoryId],[CoustomerId],[Discount],[SoldPrice],CreatedDate)values 
		(@@InventoryId, @@NewCoustomerID,@@Discount, @@Price, GETDATE())

		UPDATE [ProjectDB].[dbo].[tblInventoryData] set ToTheStore = 0 , ToTheOutside = 1, OutedDateFromStore = GETDATE() where InventoryID = @@InventoryId;
	
		-- Master warrenty
		EXEC  sp_InsertNewWarrenty @@InventoryId, @@Warrenty 
			SELECT 1

	END
	ELSE BEGIN
		SELECT 0
	END
END


--select * from tblInventoryData
GO
/****** Object:  StoredProcedure [dbo].[sp_ViewAllInventoryData]    Script Date: 13/03/2024 10:54:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Sasanka Buddhi
-- Create date: 2023-12-28
-- Description:	sp for get all inventory data to view current inventory status
--  EXEC  sp_ViewAllInventoryData NULL,NULL
-- =============================================
CREATE PROCEDURE [dbo].[sp_ViewAllInventoryData] (@FromDate DATETIME = NULL,@ToDATE DATETIME = NULL)
AS

DECLARE @@TempTableToView AS TABLE (BrandName NVARCHAR(30), VendorName NVARCHAR(30), VendorContact NVARCHAR(30), VendorEmail NVARCHAR(30), PerchesedCount INT, UnitPrice Decimal(18,2),TotalCost Decimal(18,2),InSaleInventory INT,NotInAnyStore INT, RemainingCount INT, ProductName Nvarchar(100))

BEGIN
	SET NOCOUNT ON;
	insert into @@TempTableToView  (BrandName,ProductName, VendorName, VendorContact, VendorEmail, PerchesedCount, UnitPrice,TotalCost,InSaleInventory,NotInAnyStore,RemainingCount)
	SELECT A.BrandName,A.ProductName, A.VendorName, A.VendorContact, A.VendorEmail,B.perchesedCount,B.unitPrice, (b.perchesedCount * b.unitPrice),(select count (ToTheStore) from tblInventoryData where ToTheStore = 1 and ProductCategoryId = a.ProductID and MasterId = b.mStoreId ),
	(select count (ToTheOutside) from tblInventoryData where ToTheOutside = 1 and ProductCategoryId = a.ProductID and MasterId = b.mStoreId ),
	(B.perchesedCount - ((select COUNT(ToTheOutside) from tblInventoryData where ToTheOutside = 1 AND ProductCategoryId = a.ProductID and MasterId = b.mStoreId)
	+(select COUNT(ToTheStore) from tblInventoryData where ToTheStore = 1 and ProductCategoryId = a.ProductID and MasterId = b.mStoreId))) 
	FROM tblProductCategories A 
	JOIN tblMasterStore B ON A.ProductID = B.ProductId
	left JOIN tblInventoryData C ON B.mStoreId = C.MasterId And b.ProductId = a.ProductID

	SELECT DISTINCT BrandName, VendorName, VendorContact, VendorEmail, PerchesedCount, UnitPrice,TotalCost,InSaleInventory,NotInAnyStore,RemainingCount,ProductName FROM @@TempTableToView  
END
GO
USE [master]
GO
ALTER DATABASE [ProjectDB] SET  READ_WRITE 
GO
