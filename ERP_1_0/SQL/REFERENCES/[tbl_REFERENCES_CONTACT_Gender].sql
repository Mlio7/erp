USE [ERP]
GO

/****** Object:  Table [dbo].[tbl_REFERENCES_CONTACT_Salutation]    Script Date: 16.08.2021 22:39:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_REFERENCES_CONTACT_Gender](
	[ID] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedByID] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedByID] [uniqueidentifier] NULL,
	[Name] [nvarchar](10) NOT NULL
) ON [PRIMARY]

GO


ALTER TABLE [dbo].[tbl_REFERENCES_CONTACT_Gender] 
ADD  CONSTRAINT [DF_tbl_REFERENCES_CONTACT_Gender_ID]  
DEFAULT (newid()) FOR [ID]
GO

ALTER TABLE [dbo].[tbl_REFERENCES_CONTACT_Gender] 
ADD  CONSTRAINT [DF_tbl_REFERENCES_CONTACT_Gender_CreatedOn]  
DEFAULT (getdate()) FOR [CreatedOn]
GO


Alter table [tbl_REFERENCES_CONTACT_Gender]
ADD CONSTRAINT PK_tbl_REFERENCES_CONTACT_Gender_ID
PRIMARY KEY ([ID])
GO


CREATE TRIGGER trg_REFERENCES_CONTACT_Gender_ModifiedOn
ON [dbo].[tbl_REFERENCES_CONTACT_Gender]
AFTER UPDATE
AS
UPDATE [dbo].[tbl_REFERENCES_CONTACT_Gender]
SET [ModifiedOn] = CURRENT_TIMESTAMP
WHERE [ID] IN (SELECT DISTINCT [ID] FROM inserted);

INSERT INTO [dbo].[tbl_REFERENCES_CONTACT_Gender]
           ([ID]
           ,[CreatedOn]
           ,[CreatedByID]
           ,[ModifiedOn]
           ,[ModifiedByID]
           ,[Name]
           )
     VALUES
           (default,default,default,default,default,'Чоловік'),
		   (default,default,default,default,default,'Жінка'),
		   (default,default,default,default,default,'Male'),
		   (default,default,default,default,default,'Female')

		   
GO

select * from [tbl_REFERENCES_CONTACT_Gender]