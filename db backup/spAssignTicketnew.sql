USE [ProjectDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_AssignTicket]    Script Date: 2/13/2024 2:59:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sasanka Buddhi
-- Create date: 2024 02 08
-- Description:	sp for insert Ticket
--  exec  sp_AssignTicket 5,4,3
-- =============================================
ALTER PROCEDURE [dbo].[sp_AssignTicket](@@TicketID INT, @@AssignedTo INT, @@UserID INT)
AS
DECLARE @@ISopen AS BIT, @@TicketProjectDtlId AS INT, @@ScoupIdentityID AS INT;

BEGIN
	SET NOCOUNT ON;
	
	SELECT @@ISopen =  IsOpen  FROM [ProjectDB].[dbo].[tblTicket] WHERE TicketId = @@TicketID
	--SELECT @@ISopen

	IF (@@ISopen IS NULL)
	BEGIN 
		--Implement from this
		UPDATE [ProjectDB].[dbo].[tblTicket] SET IsOpen=1,OpenedDate=GETDATE()  WHERE TicketId = @@TicketID;

		INSERT INTO [ProjectDB].[dbo].[tblTicketProjectDtl] ([TicketId],[CurrentSeqence],[Active],[CreateDate])
		VALUES (@@TicketID,(SELECT TOP 1 SequanceIndexID FROM [ProjectDB].[dbo].[tblMasterTicketSequnces] ORDER BY SequanceIndexID),1,GETDATE());
		SET @@TicketProjectDtlId = SCOPE_IDENTITY();
		--SELECT @@TicketProjectDtlId

			IF (@@TicketProjectDtlId IS NOT NULL)
			BEGIN
				INSERT INTO [ProjectDB].[dbo].[tblTicketTaskAssign] ([ticketProjectId],[AssignedFrom],[AssignedTo],[AssignedDate],[Active],[StatustId])
				VALUES (@@TicketProjectDtlId,@@UserID,@@AssignedTo,GETDATE(),1,1);

				  INSERT INTO [ProjectDB].[dbo].[tblTicketComment] (TicketID,[Comment],[CommentedDate],[CommentedBy])
				  VALUES (@@TicketID,'Ticket Open and Assigned From '+(SELECT UserName FROM [ProjectDB].[dbo].[tblUser] WHERE UserId = @@UserID)
				  +' To '+(SELECT UserName FROM [ProjectDB].[dbo].[tblUser] WHERE UserId = @@AssignedTo)+'',GETDATE(),@@UserID)

				  SET @@ScoupIdentityID = SCOPE_IDENTITY();
			
				IF (@@ScoupIdentityID IS NOT NULL)
				BEGIN
					SELECT 1;
				
				END
				ELSE
				BEGIN
					SELECT 0;
					END
			END 
			ELSE
			BEGIN
				SELECT 0;
			END
	END
	ELSE
	BEGIN
		SELECT 0;
	END

END
