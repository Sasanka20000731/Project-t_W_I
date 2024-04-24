USE [ProjectDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetDashbordDetails]    Script Date: 24/04/2024 05:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sasanka Buddhi Pramodya	
-- Create date: <Create Date,,>
-- Description:	<Description,,> 
-- =============================================
--   EXEC sp_GetDashbordDetails 2

ALTER PROCEDURE [dbo].[sp_GetDashbordDetails](@@UserId INT)
AS
BEGIN
	DECLARE @@PendingTicket INT =NULL, @@OpenedTickets INT= NULL, @@ClosedTickets INT= NULL ,@@UserLevel AS INT;

	SELECT @@UserLevel=  UserLevel  FROM [ProjectDB].[dbo].[tblUser] where UserId = @@UserId;

	IF (@@UserLevel IS NOT NULL)
	BEGIN
	-- Pending Tickets (All and induvitual)
		SELECT @@PendingTicket= COUNT(a.TicketId) FROM
		[ProjectDB].[dbo].[tblTicket] a 
		WHERE  a.IsOpen IS NULL AND  a.IsClosed IS NULL AND a.OpenedDate IS NULL

	-- Opened Tickets (All and induvitual)
		IF (@@UserLevel NOT IN (3, 4))
		BEGIN 
		SET @@OpenedTickets = 0;
			SELECT @@OpenedTickets = COUNT (a.TicketId) FROM
			[ProjectDB].[dbo].[tblTicket] a 
			WHERE  a.IsOpen = 1  AND  a.IsClosed IS NULL AND a.ClosedDate IS NULL

		END
		ELSE BEGIN
			SELECT @@OpenedTickets = COUNT(a.TicketId) FROM
					[ProjectDB].[dbo].[tblTicket] a 
					JOIN [ProjectDB].[dbo].[tblTicketProjectDtl] b ON a.TicketId = b.TicketId
					JOIN [ProjectDB].[dbo].[tblTicketTaskAssign] c ON b.TicketProjectId = c.ticketProjectId
					JOIN [ProjectDB].[dbo].[tblUser] d ON c.AssignedTo = d.UserId
					JOIn [ProjectDB].[dbo].[tblTicketStatus] e ON c.StatustId = e.TicketStatusId
					WHERE c.Active  =  1 and a.IsOpen = 1 AND a.IsClosed IS  NULL  AND c.AssignedTo = @@userId
	

		END

	-- Closed Tickets 
		SELECT @@ClosedTickets = COUNT(a.TicketId) 
		FROM [ProjectDB].[dbo].[tblTicket]  a
		where a.IsClosed = 1 AND a.ClosedDate IS NOT NULL 




	END






	SELECT @@PendingTicket AS PendingTickets , @@OpenedTickets AS OpenedTickets , @@ClosedTickets AS ClosedTickets
END
