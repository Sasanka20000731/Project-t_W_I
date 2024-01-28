USE [ProjectDB]
GO

/****** Object:  StoredProcedure [dbo].[sp_SaleItem]    Script Date: 28/01/2024 22:04:45 ******/
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

