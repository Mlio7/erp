USE [ERP]
GO

/****** Object:  Table [dbo].[tbl_REFERENCES_CONTACT_DecisionRole]    Script Date: 16.08.2021 17:24:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_REFERENCES_CONTACT_DecisionRole](
	[ID] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedByID] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedByID] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NULL
) ON [PRIMARY]

GO

ALTER TABLE [tbl_REFERENCES_CONTACT_DecisionRole]
ADD CONSTRAINT PK_tbl_REFERENCES_CONTACT_DecisionRole_ID
PRIMARY KEY ([ID])
GO
ALTER TABLE [dbo].[tbl_REFERENCES_CONTACT_DecisionRole] 
ADD  CONSTRAINT DF_tbl_REFERENCES_CONTACT_DecisionRole_ID
DEFAULT (newid()) FOR [ID]
GO

ALTER TABLE [dbo].[tbl_REFERENCES_CONTACT_DecisionRole] 
ADD  CONSTRAINT [DF_tbl_REFERENCES_CONTACT_DecisionRole_CreatedOn]  
DEFAULT (getdate()) FOR [CreatedOn]
GO

CREATE TRIGGER trg_REFERENCES_CONTACT_DecisionRole_ModifiedOn
ON [dbo].[tbl_REFERENCES_CONTACT_DecisionRole]
AFTER UPDATE
AS
UPDATE [dbo].[tbl_REFERENCES_CONTACT_DecisionRole]
SET [ModifiedOn] = CURRENT_TIMESTAMP
WHERE [ID] IN (SELECT DISTINCT [ID] FROM inserted);