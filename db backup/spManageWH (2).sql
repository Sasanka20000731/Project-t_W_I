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
--  EXEC [dbo].[sp_ManageWareHouse] 1,5,'DSADASD'

ALTER PROCEDURE [dbo].[sp_ManageWareHouse] 
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

	SET @MasterStorePercesedCount = (SELECT b.perchesedCount FROM [ProjectDB].[dbo].[tblProductCategories] a 
	JOIN [ProjectDB].[dbo].[tblMasterStore] b ON a.ProductID = b.ProductId where a.ProductID = @ProductCategory);

	
	SET @InventoryIn = (		SELECT count(c.ToTheStore) FROM [ProjectDB].[dbo].[tblMasterStore] b JOIN
	[ProjectDB].[dbo].[tblInventoryData] c on b.mStoreId = c.MasterId where c.ToTheStore = 1
	and b.ProductId = @ProductCategory )

	SET @InventoryOut	=(SELECT count(c.ToTheOutside) FROM [ProjectDB].[dbo].[tblMasterStore] b JOIN
	[ProjectDB].[dbo].[tblInventoryData] c on b.mStoreId = c.MasterId where c.ToTheOutside = 1
	and b.ProductId = @ProductCategory)
	
	Select @MasterStorePercesedCount, @InventoryIn,@InventoryOut
	--end
	IF(@MasterStorePercesedCount <= (@InventoryIn+@InventoryOut))
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
       
	SET @ReturnMessage = 'Successfully Inserted !!!';
	SELECT @ReturnMessage

	END
	ELSE
	BEGIN
	SET @ReturnMessage = 'Master Stock is Over!!!';
	SELECT @ReturnMessage
	END




END
GO

