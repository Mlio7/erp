USE [ERP]
GO

INSERT INTO [dbo].[tbl_REFERENCES_DELIVERY_StateType]
           ([ID]
           ,[CreatedOn]
           ,[CreatedByID]
           ,[ModifiedOn]
           ,[ModifiedByID]
           ,[Name]
           ,[Description])
     VALUES
           (default,--ID, uniqueidentifier,>
           default,--CreatedOn, datetime,>
           default,--CreatedByID, uniqueidentifier,>
           default,--ModifiedOn, datetime,>
           default,--ModifiedByID, uniqueidentifier,>
           'Забрано',--Name, nvarchar(250),>
           ''--Description, nvarchar(250),>
		   )
GO


