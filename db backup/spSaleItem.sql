USE [ProjectDB]
GO

/****** Object:  StoredProcedure [dbo].[sp_SaleItem]    Script Date: 15/01/2024 22:11:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Sasanka Buddhi
-- Create date: 2024-01-15
-- Description:	spForSaleItem
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaleItem] (@cName nvarchar(200),@cContact nvarchar(15), @cEmail nvarchar(200),@cAddress nvarchar(400),@cbackUpccontact nvarchar(15), @SerialNo nvarchar(max),@Discount decimal(18,2),@Price decimal(18,2),@Warrenty int)
AS

--Declare
BEGIN
	SET NOCOUNT ON;




END
GO

