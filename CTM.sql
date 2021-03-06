USE [CTM]
GO
/****** Object:  Table [dbo].[CTMUsers]    Script Date: 08.02.2022 21:19:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTMUsers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[USERNAME] [varchar](50) NOT NULL,
	[PASSWORD] [varchar](100) NOT NULL,
	[ACTIVE] [tinyint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[CTMUsers#login]    Script Date: 08.02.2022 21:19:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CTMUsers#login]
	@username varchar(100),
	@password varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * 
	FROM CTMUsers 
	WHERE 
		USERNAME = @username 
		AND PASSWORD = @password
END
GO
