USE [ERP]
GO

/****** Object:  Table [dbo].[tbl_REFERENCES_Activity_Direction]    Script Date: 16.08.2021 16:27:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_REFERENCES_Activity_Direction](
	[ID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedByID] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedByID] [uniqueidentifier] NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NULL,
 CONSTRAINT [PActivityDirectionID] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tbl_REFERENCES_Activity_Direction] 
ADD  CONSTRAINT [PDFActivityDirectionID]  
DEFAULT (newid()) FOR [ID]
GO

ALTER TABLE [dbo].[tbl_REFERENCES_Activity_Direction] 
ADD  CONSTRAINT [DF_tbl_REFERENCES_Activity_Direction_CreatedOn]  
DEFAULT (getdate()) FOR [CreatedOn]
GO

CREATE TRIGGER trg_REFERENCES_Activity_Direction_ModifiedOn
ON [dbo].[tbl_REFERENCES_Activity_Direction]
AFTER UPDATE
AS
UPDATE [dbo].[tbl_REFERENCES_Activity_Direction]
SET [ModifiedOn] = CURRENT_TIMESTAMP
WHERE [ID] IN (SELECT DISTINCT [ID] FROM inserted);
GO

INSERT INTO [dbo].[tbl_REFERENCES_Activity_Direction]
           ([ID]
           ,[CreatedOn]
           ,[CreatedByID]
           ,[ModifiedOn]
           ,[ModifiedByID]
           ,[Name]
           ,[Description])
     VALUES
           (default,default,default,default,default,'Імпорт',NULL),
		   (default,default,default,default,default,'Експорт',NULL),
		   (default,default,default,default,default,'Імпорт/Експорт',NULL),
		   (default,default,default,default,default,'Визначити',NULL);
GO
select * from [dbo].[tbl_REFERENCES_Activity_Direction]

DELETE from  [dbo].[tbl_REFERENCES_Activity_Direction] 
where [Name] =''
select * from [dbo].[tbl_REFERENCES_Activity_Direction]