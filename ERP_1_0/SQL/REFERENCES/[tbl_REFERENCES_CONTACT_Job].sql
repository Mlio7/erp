USE [ERP]
GO

/****** Object:  Table [dbo].[tbl_REFERENCES_CONTACT_Job]    Script Date: 16.08.2021 17:29:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_REFERENCES_CONTACT_Job](
	[ID] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedByID] [uniqueidentifier] NULL,
	[ModifiedByID] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime] NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[NameOf] [nvarchar](250) NULL
) ON [PRIMARY]

GO




ALTER TABLE [tbl_REFERENCES_CONTACT_Job]
ADD CONSTRAINT PK_REFERENCES_CONTACT_Job_ID
PRIMARY KEY ([ID])
GO
ALTER TABLE [dbo].[tbl_REFERENCES_CONTACT_Job] 
ADD  CONSTRAINT DF_REFERENCES_CONTACT_Job_ID
DEFAULT (newid()) FOR [ID]
GO

ALTER TABLE [dbo].[tbl_REFERENCES_CONTACT_Job] 
ADD  CONSTRAINT [DF_tbl_REFERENCES_CONTACT_Job_CreatedOn]  
DEFAULT (getdate()) FOR [CreatedOn]
GO

CREATE TRIGGER trg_REFERENCES_CONTACT_Job_ModifiedOn
ON [dbo].[tbl_REFERENCES_CONTACT_Job]
AFTER UPDATE
AS
UPDATE [dbo].[tbl_REFERENCES_CONTACT_Job]
SET [ModifiedOn] = CURRENT_TIMESTAMP
WHERE [ID] IN (SELECT DISTINCT [ID] FROM inserted);