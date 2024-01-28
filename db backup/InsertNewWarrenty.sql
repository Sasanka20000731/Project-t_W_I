USE [ProjectDB]
GO

/****** Object:  StoredProcedure [dbo].[sp_InsertNewWarrenty]    Script Date: 28/01/2024 22:04:13 ******/
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

