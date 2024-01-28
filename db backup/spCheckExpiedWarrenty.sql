USE [ProjectDB]
GO

/****** Object:  StoredProcedure [dbo].[sp_CheckExpierdWarrenty]    Script Date: 28/01/2024 22:03:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Sasanka Buddhi
-- Create date: 2024/01/25
-- Description:	sp for check day to day warrenty
-- =============================================
CREATE PROCEDURE [dbo].[sp_CheckExpierdWarrenty]
AS

BEGIN
	SET NOCOUNT ON;

	

	UPDATE tblWarrentyExtendedDate SET [Active] = 0, IsExpired = 0
	where mWarrentyId IN (SELECT mWarrentyId FROM tblMasterWarrenty WHERE IsExpired = 1)
	AND  CONVERT(DATE, warrentyExtendedToDate) = CONVERT(DATE, GETDATE());

	UPDATE tblMasterWarrenty set [IsExpiered] = 1, Active = 0 WHERE CONVERT(DATE, WarrentyExpierdDate) = CONVERT(DATE, GETDATE());


END
GO

