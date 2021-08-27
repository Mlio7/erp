USE [ERP]
GO

--/****** Object:  Table [dbo].[tbl_REFERENCES_CommunicationType]    Script Date: 16.08.2021 17:07:49 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [dbo].[tbl_REFERENCES_CommunicationType](
--	[ID] [uniqueidentifier] NOT NULL,
--	[CreatedOn] [datetime] NULL,
--	[CreatedByID] [uniqueidentifier] NULL,
--	[ModifiedOn] [datetime] NULL,
--	[ModifiedByID] [uniqueidentifier] NULL,
--	[Name] [nvarchar](250) NOT NULL,
--	[Description] [nvarchar](250) NULL,
--	[IsPhone] [int] NULL,
--	[ShellCommand] [nvarchar](250) NULL
--) ON [PRIMARY]

--GO

Alter table [tbl_REFERENCES_CommunicationType]
ADD CONSTRAINT PK_tbl_REFERENCES_CommunicationType_ID
PRIMARY KEY ([ID])
GO
ALTER TABLE [dbo].[tbl_REFERENCES_CommunicationType] 
ADD  CONSTRAINT [DF_tbl_REFERENCES_CommunicationType_ID]  
DEFAULT (newid()) FOR [ID]
GO

ALTER TABLE [dbo].[tbl_REFERENCES_CommunicationType] 
ADD  CONSTRAINT [DF_tbl_REFERENCES_CommunicationType_CreatedOn]  
DEFAULT (getdate()) FOR [CreatedOn]
GO


CREATE TRIGGER trg_REFERENCES_CommunicationType_ModifiedOn
ON [dbo].[tbl_REFERENCES_CommunicationType]
AFTER UPDATE
AS
UPDATE [dbo].[tbl_REFERENCES_CommunicationType]
SET [ModifiedOn] = CURRENT_TIMESTAMP
WHERE [ID] IN (SELECT DISTINCT [ID] FROM inserted);


INSERT INTO [dbo].[tbl_REFERENCES_CommunicationType]
           ([ID],[CreatedOn] ,[CreatedByID],[ModifiedOn],[ModifiedByID],[Name],[Description],[IsPhone],[ShellCommand])
     VALUES
           (default,default,default,default,default,'',NULL,NULL,NULL)
GO
select * FROM  [tbl_REFERENCES_CommunicationType]


delete from  [tbl_REFERENCES_CommunicationType]
where [Name] = 'changed';
GO
select * FROM  [tbl_REFERENCES_CommunicationType]