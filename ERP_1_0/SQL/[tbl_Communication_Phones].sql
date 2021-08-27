USE ERP

-- check to see if table exists in sys.tables - ignore DROP TABLE if it does not
IF EXISTS(SELECT * 
		  FROM sys.tables 
		  WHERE SCHEMA_NAME(schema_id) LIKE 'dbo' AND name like 'tbl_Communication_Data')  
   DROP TABLE [dbo].[tbl_Communication_Data];  
GO


create table [tbl_Communication_Data]
(
	[ID] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedByID] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedByID] [uniqueidentifier] NULL,
	[CompanyID] [uniqueidentifier]NULL,
	[ContactID] [uniqueidentifier]NULL,
	[LeadID] [uniqueidentifier]NULL,
	[CommunicationTypeID] [uniqueidentifier] NULL,
	[CountryPhoneCodeID] [uniqueidentifier] NULL,
	[CellNumber] char (15) ,
	[PhoneNumber] char (15),
	[FaxNumber] char (15) ,
	[Email] char (44) ,
	[Web] char (35) ,
	[Description] [nvarchar](250) NULL
)
--1.
ALTER TABLE [dbo].[tbl_Communication_Data] 
ADD  CONSTRAINT [PDFCommunication_DataID]  
DEFAULT (newid()) FOR [ID]
GO
--2.
ALTER TABLE [dbo].[tbl_Communication_Data] 
ADD  CONSTRAINT [DF_tbl_Communication_Data_CreatedOn]  
DEFAULT (getdate()) FOR [CreatedOn]
GO
--3.[CellNumber]
ALTER TABLE [dbo].[tbl_Communication_Data]  
WITH CHECK ADD  CONSTRAINT [CK__tbl_Commu__CellNumber_REGEXCHECK] 
CHECK  (([CellNumber] like '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'))
GO
--3.[PhoneNumber]
ALTER TABLE [dbo].[tbl_Communication_Data]  
WITH CHECK ADD  CONSTRAINT [CK__tbl_Commu__PhoneNumber_REGEXCHECK] 
CHECK (([PhoneNumber] like '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'))
GO
--3.[FaxNumber]
ALTER TABLE [dbo].[tbl_Communication_Data]  
WITH CHECK ADD  CONSTRAINT [CK__tbl_Commu__FaxNumber_REGEXCHECK] 
CHECK (([FaxNumber] like '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'))
GO
--4.[Email]
ALTER TABLE [dbo].[tbl_Communication_Data]  
WITH CHECK ADD  CONSTRAINT [CK__tbl_Commu__Email_REGEXCHECK] 
CHECK (([Email] like '[a-z]%@%[a-z]%.%'))
GO
--5.[Web]
ALTER TABLE [dbo].[tbl_Communication_Data]  
WITH CHECK ADD  CONSTRAINT [CK__tbl_Commu__Web_REGEXCHECK] 
CHECK (([Web] like '[a-z]%.%[a-z\.]%'))
GO



--1. PRIMARY KEY 
Alter table [tbl_Communication_Data]
ADD CONSTRAINT PK_tbl_Communication_Data_ID
PRIMARY KEY ([ID])
GO

CREATE TRIGGER trg_Communication_Data_ModifiedOn
ON [dbo].[tbl_Communication_Data]
AFTER UPDATE
AS
UPDATE [dbo].[tbl_Communication_Data]
SET [ModifiedOn] = CURRENT_TIMESTAMP
WHERE [ID] IN (SELECT DISTINCT [ID] FROM inserted);

GO



	----Alter table [tbl_Communication_Data]
	----ADD CONSTRAINT FK_tbl_Communication_Data_CompanyID
	----FOREIGN KEY (CompanyID) REFERENCES [dbo].[tbl_Company](ID)
	----GO
	----Alter table [tbl_Communication_Data]
	----ADD CONSTRAINT FK_tbl_Communication_Data_ContactID
	----FOREIGN KEY (ContactID) REFERENCES [dbo].[tbl_Contact](ID)
	----GO
	----Alter table [tbl_Communication_Data]
	----ADD CONSTRAINT FK_tbl_Communication_Data_LeadID
	----FOREIGN KEY (LeadID) REFERENCES [dbo].[tbl_Company](ID)
	----GO

Alter table [tbl_Communication_Data]
ADD CONSTRAINT FK_tbl_Communication_Data_CountryPhoneCodeID
FOREIGN KEY (CountryPhoneCodeID) REFERENCES [dbo].[tbl_REFERENCES_LOCATION_Country](ID)
GO




INSERT INTO [dbo].[tbl_Communication_Data]
           ([ID]
           ,[CreatedOn]
           ,[CreatedByID]
           ,[ModifiedOn]
           ,[ModifiedByID]
           ,[CompanyID]
           ,[ContactID]
           ,[LeadID]
           ,[CommunicationTypeID]
           ,[CountryPhoneCodeID]
           ,[CellNumber]
           ,[PhoneNumber]
           ,[FaxNumber]
           ,[Email]
           ,[Web]
           ,[Description])
Values
           (default,--[ID]
           default,--[CreatedOn]
           default,--[CreatedByID]
           default,--[ModifiedOn]
           default,--[ModifiedByID]
           default,--[CompanyID]
           default,--[ContactID]
           default,--[LeadID]
           default,--[CommunicationTypeID]
           default,--[CountryPhoneCodeID]
           '(095) 147-24-80',--[CellNumber]
           '(095) 147-24-80',--[PhoneNumber]
           '(095) 147-24-80',--[FaxNumber]
           'sdcsdc@yahoo.com',--[Email]
           'organic.com',--[Web]
           default)--[Description]
		   
GO
select * from [dbo].[tbl_Communication_Data]