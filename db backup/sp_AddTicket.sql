SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sasanka Buddhi 
-- Create date: 2024-02-12
-- Description:	sp for add tickets
-- =============================================
CREATE PROCEDURE sp_AddTicket (@@SerialNumber NVARCHAR(MAX), @@TicketRemark NVARCHAR(MAX))
AS
DECLARE @@CustomerID AS INT, @@InventoryID AS INT , @@ScoupIdentityID AS INT;

BEGIN
	SET NOCOUNT ON;

	SELECT @@InventoryID = a.InventoryID ,@@CustomerID = c.CoustomerId FROM [ProjectDB].[dbo].[tblInventoryData] a
	JOIN [ProjectDB].[dbo].[tblSalesDetails] b ON a.InventoryID = b.InventoryId
	JOIN [ProjectDB].[dbo].[tblCoustomerDetails] c ON b.CoustomerId = c.CoustomerId
	WHERE a.SerialNumber = @@SerialNumber

	INSERT INTO [tblTicket] (InventoryID,CoustomerId,TicketDiscription,CreatedDate)
	VALUES (@@InventoryID,@@CustomerID,@@TicketRemark,GETDATE());
	SET @@ScoupIdentityID = SCOPE_IDENTITY();
	
	IF (@@ScoupIdentityID IS NOT NULL)
	BEGIN
		SELECT 1;
	END ELSE
	BEGIN
		SELECT 0;
	END
  
END
GO
