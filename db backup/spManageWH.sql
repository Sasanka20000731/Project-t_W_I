USE [ProjectDB]
GO

/****** Object:  StoredProcedure [dbo].[sp_ViewAllInventoryData]    Script Date: 1/3/2024 4:42:03 PM ******/
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

