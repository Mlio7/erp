USE [ERP]
GO

/****** Object:  Table [dbo].[tbl_REFERENCES_COMPANY_Department]    Script Date: 17.08.2021 0:42:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_REFERENCES_COMPANY_Department](
	[ID] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedByID] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedByID] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NULL
) ON [PRIMARY]

GO



ALTER TABLE [dbo].[tbl_REFERENCES_COMPANY_Department] 
ADD  CONSTRAINT [PDFCOMPANYDepartmentID]  
DEFAULT (newid()) FOR [ID]
GO

ALTER TABLE [dbo].[tbl_REFERENCES_COMPANY_Department] 
ADD  CONSTRAINT [DF_tbl_REFERENCES_COMPANY_Department_CreatedOn]  
DEFAULT (getdate()) FOR [CreatedOn]
GO
--1. PRIMARY KEY 
Alter table [tbl_REFERENCES_COMPANY_Department]
ADD CONSTRAINT PK_tbl_REFERENCES_COMPANY_Department_ID
PRIMARY KEY ([ID])
GO

CREATE TRIGGER trg_REFERENCES_COMPANY_Department_ModifiedOn
ON [dbo].[tbl_REFERENCES_COMPANY_Department]
AFTER UPDATE
AS
UPDATE [dbo].[tbl_REFERENCES_COMPANY_Department]
SET [ModifiedOn] = CURRENT_TIMESTAMP
WHERE [ID] IN (SELECT DISTINCT [ID] FROM inserted);
GO


select * from [tbl_REFERENCES_COMPANY_Department]


--update [tbl_REFERENCES_COMPANY_Department]
--set [CreatedByID] = NULL,
--[ModifiedOn]=null,
--[ModifiedByID]=null
--select * from [tbl_REFERENCES_COMPANY_Department]
