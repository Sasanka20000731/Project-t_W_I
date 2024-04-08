USE [ProjectDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_WarrentyManagementReport]    Script Date: 4/8/2024 2:53:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON 
GO
-- =============================================
-- Author:		Sasanka Buddhi
-- Create date: 2024-03-30	
-- Description:	sp for Ticket Management Reports
----1	Valid Warrenty
----2	Expired Warrenties
----3	Extended Warrenties

--	exec [dbo].[sp_WarrentyManagementReport] '2023-02-02 00:00:00.001','2024-05-02 00:00:00.001',4,3

-- =============================================
ALTER PROCEDURE [dbo].[sp_WarrentyManagementReport](@@FromDate DATETIME,@@ToDate DATETIME,@@ReportCategory INT,@@ReportType INT)
AS

DECLARE @@TempTable AS TABLE ( COL1 NVARCHAR(MAX),COL2 NVARCHAR(MAX), COL3 NVARCHAR(MAX),COL4 NVARCHAR(MAX))
BEGIN
	SET NOCOUNT ON;

	IF (@@ReportCategory = 4 AND @@ReportType = 1) --Active Warrenty
	BEGIN
		INSERT INTO @@TempTable(COL1, COL2, COL3, COL4)
		SELECT 'Active Warrenty on : '+ b.SerialNumber+' up to '+CONVERT(NVARCHAR(200), a.WarrentyExpierdDate)
		,'Warrenty Start on : ' +CONVERT(NVARCHAR(200), a.WarrentyStartDate),'Customer : '+ d.CoustomerName, 'Contact No :'+ d.ContactNumber
		FROM [ProjectDB].[dbo].[tblMasterWarrenty]  a
		LEFT JOIN [ProjectDB].[dbo].[tblInventoryData] b ON a.inventoryId = b.InventoryID
		LEFT JOIN [ProjectDB].[dbo].[tblSalesDetails] c ON b.InventoryID = c.InventoryId
		LEFT JOIN [ProjectDB].[dbo].[tblCoustomerDetails] d ON c.CoustomerId = d.CoustomerId
		WHERE a.IsExpiered IS NULL AND a.Active = 1 AND d.Active = 1
		AND a.WarrentyStartDate BETWEEN @@FromDate AND @@ToDate
	END

	IF (@@ReportCategory = 4 AND @@ReportType = 2) --Expired Warrenties
	BEGIN
		INSERT INTO @@TempTable(COL1, COL2, COL3, COL4)
		SELECT 'Warrenty Expired on : '+ b.SerialNumber +' After '+CONVERT(NVARCHAR(30),a.WarrentyMonths)
		, 'Wrrenty started on'+CONVERT(NVARCHAR(200), a.WarrentyStartDate)+  'Warrenty Expired on : ' +CONVERT(NVARCHAR(200), a.WarrentyExpierdDate),'Customer : '+ d.CoustomerName, 'Contact No :'+ d.ContactNumber
		FROM [ProjectDB].[dbo].[tblMasterWarrenty]  a
		LEFT JOIN [ProjectDB].[dbo].[tblInventoryData] b ON a.inventoryId = b.InventoryID
		LEFT JOIN [ProjectDB].[dbo].[tblSalesDetails] c ON b.InventoryID = c.InventoryId
		LEFT JOIN [ProjectDB].[dbo].[tblCoustomerDetails] d ON c.CoustomerId = d.CoustomerId
		WHERE a.IsExpiered = 1  AND a.Active = 1 AND d.Active = 1 AND a.WarrentyExpierdDate BETWEEN @@FromDate AND @@ToDate
	END 



	IF (@@ReportCategory = 4 AND @@ReportType = 3) --Extended Warrenty
	BEGIN
		INSERT INTO @@TempTable(COL1, COL2, COL3, COL4)
		SELECT 'Serial No: '+c.SerialNumber
		, 'Warrenty Expired on'+ CONVERT(NVARCHAR(200), a.WarrentyExpierdDate)
		, 'Extended From : '+CONVERT(NVARCHAR(200), b.warrentyExtendedFromDate) +' To : '+ CONVERT(NVARCHAR(200), b.warrentyExtendedToDate)
		, 'Warrenty Extended Date '+CONVERT(NVARCHAR(200), b.createddate)
		FROM [ProjectDB].[dbo].[tblMasterWarrenty]  a
		JOIN [ProjectDB].[dbo].[tblWarrentyExtendedDate] b ON a.mWarrentyId = b.mWarrentyId
		JOIN [ProjectDB].[dbo].[tblInventoryData] c on a.inventoryId = c.InventoryID
		WHERE b.createddate BETWEEN @@FromDate AND @@ToDate
	END




	

	SELECT * FROM  @@TempTable
END



		
