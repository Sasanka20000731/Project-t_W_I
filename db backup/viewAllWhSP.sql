USE [ProjectDB]
GO

/****** Object:  StoredProcedure [dbo].[sp_ManageWareHouse]    Script Date: 02/01/2024 23:05:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Sasanka Buddhi
-- Create date: 2023 12 30
-- Description:	sp for Manage WareHouse
-- =============================================
--- EXEC [dbo].[sp_ManageWareHouse] 1,6,'DSADASD'

CREATE PROCEDURE [dbo].[sp_ManageWareHouse] 
    @dataType int,
    @ProductCategory int,
    --@MasterStore int,
    @SerialNo NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @InsertedId INT;
	DECLARE @TempTable AS TABLE (ProductCategoryId INT,[MasterId] INT,[SerialNumber] NVARCHAR(MAX),[ToTheStore] BIT,[ToTheOutside] BIT,[InsertedDate] DATETIME NULL,[OutedDateFromStore] DATETIME NULL)
	
SELECT @ProductCategory, (SELECT b.mStoreId FROM tblProductCategories a
join tblMasterStore b on a.ProductID = b.ProductId
where a.ProductID = @ProductCategory), @SerialNo



        Insert Into [ProjectDB].[dbo].[tblInventoryData] 
            ([ProductCategoryId],[MasterId],[SerialNumber],[ToTheStore],[ToTheOutside],[InsertedDate],[OutedDateFromStore])
        values 
            (@ProductCategory, (SELECT b.mStoreId FROM tblProductCategories a
				join tblMasterStore b on a.ProductID = b.ProductId
				where a.ProductID = @ProductCategory), @SerialNo, 
             CASE WHEN @dataType = 1 THEN 1 ELSE 0 END, 
             CASE WHEN @dataType = 2 THEN 1 ELSE 0 END,
             CASE WHEN @dataType = 1 THEN GETDATE() ELSE NULL END, 
             CASE WHEN @dataType = 2 THEN GETDATE() ELSE NULL END);

     SET @InsertedId = SCOPE_IDENTITY();
   select * from tblInventoryData 
   IF @InsertedId IS NULL
    BEGIN 
        select 0 AS RESULT;
    END
    ELSE
    BEGIN
        select 10 AS RESULT;
    END

END




GO

