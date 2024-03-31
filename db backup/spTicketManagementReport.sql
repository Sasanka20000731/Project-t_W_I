USE [ProjectDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_TicketManagementReport]    Script Date: 31/03/2024 21:34:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sasanka Buddhi
-- Create date: 2024-03-30	
-- Description:	sp for Ticket Management Reports
----ReportTypeValue	ReportTypeName
----1	Pending Tickets
----2	Tickets In Handlers
----3	Tickets In Manager
----4	Closed Tickets
----5	Individual User
-- =============================================
ALTER PROCEDURE [dbo].[sp_TicketManagementReport](@@FromDate DATETIME,@@ToDate DATETIME,@@ReportCategory INT,@@ReportType INT, @@ReportUser INT = NULL)
AS

DECLARE @@TempTable AS TABLE ( COL1 NVARCHAR(MAX),COL2 NVARCHAR(MAX), COL3 NVARCHAR(MAX),COL4 NVARCHAR(MAX))
BEGIN
	SET NOCOUNT ON;

	IF (@@ReportCategory = 3 AND @@ReportType = 1) --Pending Ticket
	BEGIN
		SELECT * FROM [ProjectDB].[dbo].[tblTicket] where IsOpen IS NULL AND IsClosed IS NULL AND OpenedDate IS NULL AND ClosedDate IS NULL
	END


	IF ((@@ReportCategory= 3 AND @@ReportType = 2) OR (@@ReportCategory= 3 AND @@ReportType = 3))  -- Ticket handler / tickert manager
	BEGIN
			
		SELECT * FROM [ProjectDB].[dbo].[tblTicket] a 
		JOIN [ProjectDB].[dbo].[tblTicketProjectDtl] b on a.TicketId = b.TicketId
		JOIN [ProjectDB].[dbo].[tblTicketComment] e on a.TicketId  = e.TicketID
		WHERE b.CurrentSeqence = @@ReportType AND a.IsClosed IS NULL

	END

	IF (@@ReportCategory = 3 AND @@ReportType = 4) -- closed
	BEGIN
		SELECT * FROM [ProjectDB].[dbo].[tblTicket] a 
		JOIN [ProjectDB].[dbo].[tblTicketProjectDtl] b on a.TicketId = b.TicketId
		JOIN [ProjectDB].[dbo].[tblTicketComment] e on a.TicketId  = e.TicketID
		WHERE a.IsClosed = 1
	END

	IF (@@ReportCategory = 3 AND @@ReportType = 5 AND @@ReportUser IS NOT NULL )
	BEGIN
				SELECT * FROM [ProjectDB].[dbo].[tblTicket] a 
		JOIN [ProjectDB].[dbo].[tblTicketProjectDtl] b on a.TicketId = b.TicketId
		JOIN [ProjectDB].[dbo].[tblTicketComment] c on a.TicketId  = c.TicketID
		JOIN [ProjectDB].[dbo].[tblTicketTaskAssign] d on b.TicketProjectId = d.ticketProjectId
		where d.AssignedTo = 5 AND a.IsClosed IS NULL 
	END

	SELECT * FROM  @@TempTable
END



