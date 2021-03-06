/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[CreatedOn]
      ,[CreatedByID]
      ,[ModifiedOn]
      ,[ModifiedByID]
      ,[Name]
      ,[Description]
      ,[Code]
      ,[IsPhone]
      ,[ShellCommand]
      ,[ActionIcon]
  FROM [ERP].[dbo].[tbl_REFERENCES_CommunicationType]

  alter table [tbl_REFERENCES_CommunicationType]
  drop column [Code]

  select * from [tbl_REFERENCES_CommunicationType]

  update  [tbl_REFERENCES_CommunicationType]
  set [CreatedOn] = getdate();
  select * from [tbl_REFERENCES_CommunicationType]

  update  [tbl_REFERENCES_CommunicationType]
  set [CreatedByID] = NULL,
  [ModifiedOn] = NULL,
  [ModifiedByID] = NULL;
  Go
  select * from [tbl_REFERENCES_CommunicationType]

