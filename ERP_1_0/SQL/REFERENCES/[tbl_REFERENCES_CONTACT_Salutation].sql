USE [ERP]
GO

/****** Object:  Table [dbo].[tbl_REFERENCES_CONTACT_Salutation]    Script Date: 16.08.2021 22:39:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_REFERENCES_CONTACT_Salutation](
	[ID] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedByID] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedByID] [uniqueidentifier] NULL,
	[Name] [nvarchar](10) NOT NULL,
	[Description] [nvarchar](150) NULL
) ON [PRIMARY]

GO


ALTER TABLE [dbo].[tbl_REFERENCES_CONTACT_Salutation] 
ADD  CONSTRAINT [DF_tbl_REFERENCES_CONTACT_Salutation_ID]  
DEFAULT (newid()) FOR [ID]
GO

ALTER TABLE [dbo].[tbl_REFERENCES_CONTACT_Salutation] 
ADD  CONSTRAINT [DF_tbl_REFERENCES_CONTACT_Salutation_CreatedOn]  
DEFAULT (getdate()) FOR [CreatedOn]
GO


Alter table [tbl_REFERENCES_CONTACT_Salutation]
ADD CONSTRAINT PK_tbl_REFERENCES_CONTACT_Salutation_ID
PRIMARY KEY ([ID])
GO


CREATE TRIGGER trg_REFERENCES_CONTACT_Salutation_ModifiedOn
ON [dbo].[tbl_REFERENCES_CONTACT_Salutation]
AFTER UPDATE
AS
UPDATE [dbo].[tbl_REFERENCES_CONTACT_Salutation]
SET [ModifiedOn] = CURRENT_TIMESTAMP
WHERE [ID] IN (SELECT DISTINCT [ID] FROM inserted);

INSERT INTO [dbo].[tbl_REFERENCES_CONTACT_Salutation]
           ([ID]
           ,[CreatedOn]
           ,[CreatedByID]
           ,[ModifiedOn]
           ,[ModifiedByID]
           ,[Name]
           ,[Description])
     VALUES
           (default,default,default,default,default,'г-н',NULL),
		   (default,default,default,default,default,'г-жа',NULL),
		   (default,default,default,default,default,'Mr','Kогда мы говорим о мужчине(не важно, женатом или не женатом)'),
		   (default,default,default,default,default,'Mrs','Когда говорим о жене'),
		   (default,default,default,default,default,'Miss','Kогда мы говорим о женщине/девушке, которая не замужем.'),
		   (default,default,default,default,default,'Ms','/mɪz/ Когда нам неизвестно, замужем девушка или нет')
		   
GO

select * from [tbl_REFERENCES_CONTACT_Salutation]