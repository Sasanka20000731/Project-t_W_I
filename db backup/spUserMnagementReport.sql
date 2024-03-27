USE [ProjectDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_UserManageReport]    Script Date: 3/25/2024 2:12:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sasanka Buddhi	
-- Create date: 2024-03-20
-- Description:	Sp for User Manage Report
-- EXEC [dbo].[sp_UserManageReport] '2024-01-01','2024-10-30',1,3
-- =============================================

ALTER PROCEDURE [dbo].[sp_UserManageReport] (@@FromDate DATETIME,@@ToDate DATETIME, @@ReportCategory INT,@@ReportType INT)
AS

DECLARE @@TempTable AS TABLE (FullName NVARCHAR(200), CreateDate DATETIME,[Status] NVARCHAR(30),UserLevel NVARCHAR(200) NULL,Remark NVARCHAR(MAX) NULL)

BEGIN
	SET NOCOUNT ON;

	IF (@@ReportCategory = 1)
	BEGIN
		IF (@@ReportType IN (1,4))
		BEGIN
			INSERT INTO  @@TempTable (FullName, CreateDate,[Status],UserLevel,Remark)
			SELECT a.FirstName+' '+a.LastName, a.CreatedDate, 
			(CASE WHEN a.Active= 1 THEN 'Active' ELSE 'Deactivated' END),b.UserLevel,
			(CASE WHEN a.AssignedTicketSequnceGroup IS NOT NULL THEN c.SequnceName ELSE 'N/A' END)
			FROM [ProjectDB].[dbo].[tblUser] a
			LEFT join [ProjectDB].[dbo].[tblUserlLevel] b on a.UserLevel = b.UserlevelID
			LEFT join [ProjectDB].[dbo].[tblMasterTicketSequnces] c on a.AssignedTicketSequnceGroup = c.SequanceIndexID
			WHERE a.CreatedDate BETWEEN @@FromDate AND @@ToDate AND a.Active = CASE  WHEN @@ReportType = 1 THEN 1 WHEN @@ReportType = 4 THEN  0 END
			SELECT * FROM @@TempTable

		END
		IF (@@ReportType = 2)
		BEGIN
			INSERT INTO  @@TempTable (FullName, CreateDate,[Status],UserLevel,Remark)
			SELECT CoustomerName, CreatedDate,(CASE WHEN Active= 1 THEN 'Active' ELSE 'Deactivated' END),'Customer', 
		    (CASE WHEN ContactNumber IS NOT NULL THEN 'Mobile No: '+ContactNumber ELSE '' END)+ +
			(CASE WHEN Email IS NOT NULL THEN ' Email: ' +Email ELSE '' END)
			FROM [ProjectDB].[dbo].[tblCoustomerDetails] WHERE Active = 1 AND 
			CreatedDate BETWEEN @@FromDate AND @@ToDate
			SELECT * FROM @@TempTable
		END
		IF (@@ReportType = 3)
		BEGIN
			INSERT INTO  @@TempTable (FullName, CreateDate,[Status],UserLevel,Remark) 
			SELECT VendorName, CreateDate,(CASE WHEN Active= 1 THEN 'Active' ELSE 'Deactivated' END), 'Vendor',
			(CASE WHEN VendorContact IS NOT NULL THEN 'Mobile No: '+VendorContact ELSE '' END)+ +
			(CASE WHEN VendorEmail IS NOT NULL THEN ' Email: ' +VendorEmail ELSE '' END)+ +
			(CASE WHEN VendorAddress IS NOT NULL THEN ' Address: ' +VendorAddress ELSE '' END)
			FROM [ProjectDB].[dbo].[tblProductCategories] WHERE Active = 1
			AND CreateDate BETWEEN @@FromDate AND @@ToDate
			SELECT * FROM @@TempTable
		END 

	END


END
