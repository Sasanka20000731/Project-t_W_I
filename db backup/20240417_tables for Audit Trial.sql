USE [ProjectDB]
GO
/****** Object:  Table [dbo].[tblAuditTrial]    Script Date: 4/17/2024 8:56:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAuditTrial](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AuditTrialType] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_tblAuditTrial] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblAuditTrialTypes]    Script Date: 4/17/2024 8:56:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAuditTrialTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AuditTrialType] [nvarchar](50) NULL,
	[Active] [bit] NULL,
	[CreatedDate] [datetime] NULL, 
 CONSTRAINT [PK_tblAuditTrialTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblAuditTrial] ON 
GO
INSERT [dbo].[tblAuditTrial] ([Id], [AuditTrialType], [Description], [CreatedBy], [CreatedDate]) VALUES (1, 1, N'adasfaasfa', 2, CAST(N'2024-04-17T08:13:21.713' AS DateTime))
GO
INSERT [dbo].[tblAuditTrial] ([Id], [AuditTrialType], [Description], [CreatedBy], [CreatedDate]) VALUES (5, 5, N'Logged In User Admin', 2, CAST(N'2024-04-17T08:51:48.487' AS DateTime))
GO
INSERT [dbo].[tblAuditTrial] ([Id], [AuditTrialType], [Description], [CreatedBy], [CreatedDate]) VALUES (6, 5, N'Logged In User Admin', 2, CAST(N'2024-04-17T08:53:09.950' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tblAuditTrial] OFF
GO
SET IDENTITY_INSERT [dbo].[tblAuditTrialTypes] ON 
GO
INSERT [dbo].[tblAuditTrialTypes] ([Id], [AuditTrialType], [Active], [CreatedDate]) VALUES (1, N'Insert', 1, CAST(N'2024-04-17T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[tblAuditTrialTypes] ([Id], [AuditTrialType], [Active], [CreatedDate]) VALUES (2, N'Update', 1, CAST(N'2024-04-17T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[tblAuditTrialTypes] ([Id], [AuditTrialType], [Active], [CreatedDate]) VALUES (3, N'Delete', 1, CAST(N'2024-04-17T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[tblAuditTrialTypes] ([Id], [AuditTrialType], [Active], [CreatedDate]) VALUES (4, N'Read', 1, CAST(N'2024-04-17T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[tblAuditTrialTypes] ([Id], [AuditTrialType], [Active], [CreatedDate]) VALUES (5, N'Log', 1, CAST(N'2024-04-17T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tblAuditTrialTypes] OFF
GO
ALTER TABLE [dbo].[tblAuditTrial]  WITH CHECK ADD  CONSTRAINT [FK_tblAuditTrial_tblAuditTrialTypes] FOREIGN KEY([AuditTrialType])
REFERENCES [dbo].[tblAuditTrialTypes] ([Id])
GO
ALTER TABLE [dbo].[tblAuditTrial] CHECK CONSTRAINT [FK_tblAuditTrial_tblAuditTrialTypes]
GO
ALTER TABLE [dbo].[tblAuditTrial]  WITH CHECK ADD  CONSTRAINT [FK_tblAuditTrial_tblUser] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[tblUser] ([UserId])
GO
ALTER TABLE [dbo].[tblAuditTrial] CHECK CONSTRAINT [FK_tblAuditTrial_tblUser]
GO
