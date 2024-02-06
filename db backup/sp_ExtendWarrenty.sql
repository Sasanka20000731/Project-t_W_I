USE [ProjectDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_ExtendWarrenty]    Script Date: 06/02/2024 21:04:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sasanka Buddhi 
-- Create date: 2024 02 05
-- Description:	sp for warrenty exend 
-- =============================================
ALTER PROCEDURE [dbo].[sp_ExtendWarrenty] (@@SerialNumber NVARCHAR(MAX),@@WarrentyMonths INT, @@ExtendCost DECIMAL(18,2))
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
