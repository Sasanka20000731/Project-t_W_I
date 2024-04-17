SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sasanka Buddhi Pramodya
-- Create date: 2024 04 17
-- Description:	sp for audit trial
-- =============================================
-- exec sp_AuditTrial 1,'adasfaasfa',300
--select * from tblAuditTrial

ALTER PROCEDURE sp_AuditTrial (@@AuditTrialType INT,@@Description NVARCHAR(MAX),@@CreatedBy INT)
AS
BEGIN 
	SET NOCOUNT ON;
	BEGIN TRY
		INSERT INTO [ProjectDB].[dbo].[tblAuditTrial] ([AuditTrialType],[Description],[CreatedBy],[CreatedDate])
		VALUES (@@AuditTrialType,@@Description,@@CreatedBy,GETDATE())
	END TRY 
	BEGIN CATCH
			IF @@TRANCOUNT < 0 
			ROLLBACK ;
	END CATCH
END
GO
