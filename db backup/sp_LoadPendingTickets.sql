USE [ProjectDB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sasanka Buddhi	
-- Create date: 2024-02-15
-- Description:	sp for get Pending Tickets
--  exec [ProjectDB].[dbo].[sp_LogadPendingTickets] 5
-- =============================================
ALTER PROCEDURE sp_LogadPendingTickets (@@UserID INT)
AS
 
DECLARE @@TempTable AS TABLE (TicketID INT, TicketDescription NVARCHAR(MAX), AssignDate DATETIME,CurrentStatus NVARCHAR(30))
BEGIN
	SET NOCOUNT ON;
	INSERT INTO @@TempTable (TicketID,TicketDescription,AssignDate,CurrentStatus)
	select a.TicketId,a.TicketDiscription, c.AssignedDate,e.TicketStatus from
	[ProjectDB].[dbo].[tblTicket] a 
	JOIN [ProjectDB].[dbo].[tblTicketProjectDtl] b on a.TicketId = b.TicketId
	JOIN [ProjectDB].[dbo].[tblTicketTaskAssign] c on b.TicketProjectId = c.ticketProjectId
	JOIN [ProjectDB].[dbo].[tblUser] d on c.AssignedTo = d.UserId
	JOIn [ProjectDB].[dbo].[tblTicketStatus] e on c.StatustId = e.TicketStatusId
	WHERE c.Active  =  1 and  c.AssignedTo = @@UserID

	SELECT * FROM @@TempTable

END
GO
--select * from [ProjectDB].[dbo].[tblTicketTaskAssign]