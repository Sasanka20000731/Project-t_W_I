USE [ProjectDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_InventoryManagementReport]    Script Date: 24/03/2024 22:19:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sasanka Buddhi
-- Create date: 2024-03-23	
-- Description:	sp for Inverntory Management Reports
-- =============================================
ALTER PROCEDURE [dbo].[sp_InventoryManagementReport](@@FromDate DATETIME,@@ToDate DATETIME,@@ReportCategory INT,@@ReportType INT)
AS

DECLARE @@TempTable AS TABLE ( COL1 NVARCHAR(MAX),COL2 NVARCHAR(MAX), COL3 NVARCHAR(MAX),COL4 NVARCHAR(MAX))
BEGIN
	SET NOCOUNT ON;
	 
	IF (@@ReportCategory = 2 AND @@ReportType = 2)
	BEGIN
		INSERT INTO @@TempTable (COL1,COL2,COL3)
		SELECT 
		'Brand Name : ' + BrandName,
		'Product Name : ' + ProductName,
		'Vendor : ' + VendorName + ' (' + VendorAddress + ' , Contact: ' + VendorContact + ' , Created on ' + CONVERT(VARCHAR(10), CreateDate, 101) + ')' AS VendorInfo
		FROM [ProjectDB].[dbo].[tblProductCategories]
		WHERE CreateDate BETWEEN @@FromDate AND @@ToDate AND Active = 1
	END

	IF (@@ReportCategory = 2 AND @@ReportType = 3)
	BEGIN
		INSERT INTO @@TempTable (COL1,COL2,COL3)
		SELECT DISTINCT 'Brand : ' + A.BrandName + ', Product : ' + A.ProductName + ', Vendor: ' + A.VendorName,
		   'Purchased Count: ' + CAST(B.perchesedCount AS VARCHAR) + ' and One Unit Cost is :' + CAST(B.unitPrice AS VARCHAR) + ' Purchased on :' + CONVERT(VARCHAR(10), b.PerchesedDate, 101),
		   'Remaining units count in sale store : ' + CAST((SELECT COUNT(ToTheStore) FROM tblInventoryData WHERE ToTheStore = 1 AND ProductCategoryId = A.ProductID AND MasterId = B.mStoreId) AS VARCHAR)
			+ ', Remaining units count in main wh :' + CAST((B.perchesedCount - ((SELECT COUNT(ToTheOutside) FROM tblInventoryData WHERE ToTheOutside = 1 AND ProductCategoryId = A.ProductID AND MasterId = B.mStoreId)
		+ (SELECT COUNT(ToTheStore) FROM tblInventoryData WHERE ToTheStore = 1 AND ProductCategoryId = A.ProductID AND MasterId = B.mStoreId))) AS VARCHAR)
		FROM tblProductCategories A 
		JOIN tblMasterStore B ON A.ProductID = B.ProductId
		LEFT JOIN tblInventoryData C ON B.mStoreId = C.MasterId AND B.ProductId = A.ProductID
	END

		IF (@@ReportCategory = 2 AND @@ReportType = 4)
	BEGIN
		INSERT INTO @@TempTable (COL1,COL2,COL3)
		SELECT DISTINCT 'Brand : ' + A.BrandName + ', Product : ' + A.ProductName + ', Vendor: ' + A.VendorName,
		   'Purchased Count: ' + CAST(B.perchesedCount AS VARCHAR) + ' and One Unit Cost is :' + CAST(B.unitPrice AS VARCHAR) + ' Purchased on :' + CONVERT(VARCHAR(10), b.PerchesedDate, 101),
		   'Remaining units count in sale store : ' + CAST((SELECT COUNT(ToTheStore) FROM tblInventoryData WHERE ToTheStore = 1 AND ProductCategoryId = A.ProductID AND MasterId = B.mStoreId) AS VARCHAR)
			+ ', Out units count in main wh :' + CAST((B.perchesedCount - ((select COUNT(ToTheOutside) from tblInventoryData where ToTheOutside = 1 AND ProductCategoryId = a.ProductID and MasterId = b.mStoreId)
			+(select COUNT(ToTheStore) from tblInventoryData where ToTheStore = 1 and ProductCategoryId = a.ProductID and MasterId = b.mStoreId))) AS VARCHAR)
		FROM tblProductCategories A 
		JOIN tblMasterStore B ON A.ProductID = B.ProductId
		LEFT JOIN tblInventoryData C ON B.mStoreId = C.MasterId AND B.ProductId = A.ProductID
	END
	SELECT * FROM  @@TempTable
END



