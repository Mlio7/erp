
USE ERP

-- check to see if table exists in sys.tables - ignore DROP TABLE if it does not
IF EXISTS(SELECT * 
		  FROM sys.tables 
		  WHERE SCHEMA_NAME(schema_id) LIKE 'dbo' AND name like 'tbl_Company')  
   DROP TABLE [dbo].[tbl_Company];  
GO

--EXEC sp_fkeys [tbl_Company]
create table [tbl_Company]
(
	[ID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedByID] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedByID] [uniqueidentifier] NULL,
	[ResponsibleUserID] [uniqueidentifier] NULL,
	[CompanyShortName] [nvarchar](35) NOT NULL,
	[ContactID] [uniqueidentifier] NULL,
	--[CompanyOfficialNameID] [uniqueidentifier] NULL,
	[RelationshipTypeID][uniqueidentifier] NULL,
	[FieldID][uniqueidentifier] NULL,
	[FieldActivityID][uniqueidentifier] NULL,
	[ActivityDirectionID][uniqueidentifier] NULL,
	[AddressTypeID][uniqueidentifier] NULL,
    [ContinentID][uniqueidentifier] NULL,
    [CountryID][uniqueidentifier] NULL,
	[StateID][uniqueidentifier] NULL,
	[CityID][uniqueidentifier] NULL,
    [ZIP][nvarchar](20) NULL,
	[Communication_CellNumber][nvarchar](15) NULL,
    [Communication_PhoneNumber][nvarchar](15) NULL,
    [Communication_FaxNumber][nvarchar](15) NULL,
    [Communication_Email][nvarchar](44) NULL,
    [Communication_Web][nvarchar](44) NULL,
	[CountryPhoneCodeID] [uniqueidentifier] NULL,
	[Communication_CellNumberTypeID][uniqueidentifier],
    [Communication_PhoneNumberTypeID][uniqueidentifier],
    [Communication_FaxNumberTypeID][uniqueidentifier],
    [Communication_EmailTypeID][uniqueidentifier],
    [Communication_WebTypeID][uniqueidentifier],
	[Active] BIT NOT NULL CONSTRAINT [DF_tbl_Company_Active] DEFAULT 1,
	[Description] [nvarchar](250) NULL

)

--DEFAULT VALUES AND CHECKS
		ALTER TABLE [dbo].[tbl_Company] 
		ADD  CONSTRAINT [PDFCompanyID]  
		DEFAULT (newid()) FOR [ID]
		GO
		--2.
		ALTER TABLE [dbo].[tbl_Company] 
		ADD  CONSTRAINT [DF_tbl_Company_CreatedOn]  
		DEFAULT (getdate()) FOR [CreatedOn]
		GO
		--3.[CellNumber]
	ALTER TABLE [dbo].[tbl_Company]  
	WITH CHECK ADD  CONSTRAINT [CK__tbl_Company__REGEXCHECK_CellNumber] 
	CHECK  (([Communication_CellNumber] like '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'))
			ALTER TABLE [dbo].[tbl_Company]  
			ADD  CONSTRAINT [CK__tbl_Company__DEFAULT_Communication_CellNumberTypeID] 
			DEFAULT  'FA08FC2A-9D55-40C9-9576-0017EAED3E49' for [Communication_CellNumberTypeID]
	--4.[PhoneNumber]
	ALTER TABLE [dbo].[tbl_Company]  
	WITH CHECK ADD  CONSTRAINT [CK__tbl_Company__REGEXCHECK_PhoneNumber] 
	CHECK (([Communication_PhoneNumber] like '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'))
			ALTER TABLE [dbo].[tbl_Company]  
			ADD  CONSTRAINT [CK__tbl_Company__DEFAULT_Communication_PhoneNumberTypeID] 
			DEFAULT  'DBCB6A43-D99F-45AE-9B41-037DE595242E' for [Communication_PhoneNumberTypeID]
	--5.[FaxNumber]
	ALTER TABLE [dbo].[tbl_Company]  
	WITH CHECK ADD  CONSTRAINT [CK__tbl_Company__REGEXCHECK_FaxNumber] 
	CHECK (([Communication_FaxNumber] like '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'))
			ALTER TABLE [dbo].[tbl_Company]  
			ADD  CONSTRAINT [CK__tbl_Company__DEFAULT_Communication_FaxNumberTypeID] 
			DEFAULT  '82696D8B-71AE-4BA4-94FD-3F77474D74E7' for [Communication_FaxNumberTypeID]
	--6.[Email]
	ALTER TABLE [dbo].[tbl_Company]  
	WITH CHECK ADD  CONSTRAINT [CK__tbl_Company__REGEXCHECK_Email] 
	CHECK (([Communication_Email] like '[a-z]%@%[a-z]%.%'))
			ALTER TABLE [dbo].[tbl_Company]  
			ADD  CONSTRAINT [CK__tbl_Company__DEFAULT_Communication_EmailTypeID] 
			DEFAULT  '7A628D16-D7D0-4979-B8BA-B64EF54A0366' for [Communication_EmailTypeID]
	--7.[Web]
	ALTER TABLE [dbo].[tbl_Company]  
	WITH CHECK ADD  CONSTRAINT [CK__tbl_Company__REGEXCHECK_Web] 
	CHECK (([Communication_Web] like '[a-z]%.%[a-z\.]%'))
			ALTER TABLE [dbo].[tbl_Company]  
			ADD  CONSTRAINT [CK__tbl_Company__DEFAULT_Communication_WebType] 
			DEFAULT  '7B77F07B-9976-47D6-95AA-D161FF369D6D' for [Communication_WebTypeID]
GO
	--8.	
	ALTER TABLE [dbo].[tbl_Company]  
	ADD  CONSTRAINT [CK__tbl_Company__UNIQUE_ShortName] unique ([CompanyShortName] )
	GO

--------------------------TRIGGERS
CREATE TRIGGER trg_Company_ModifiedOn
ON [dbo].[tbl_Company]
AFTER UPDATE
AS
UPDATE [dbo].[tbl_Company]
SET [ModifiedOn] = CURRENT_TIMESTAMP
WHERE [ID] IN (SELECT DISTINCT [ID] FROM inserted);
GO

-------------------------KEYS
--1. PRIMARY KEY 
Alter table [tbl_Company]
ADD CONSTRAINT PK_tbl_Company_ID
PRIMARY KEY ([ID])
GO
		--2. [tbl_Company]
		ALTER TABLE [dbo].[tbl_Company]  WITH CHECK ADD  CONSTRAINT [FK_CopmanyContactID] FOREIGN KEY([ContactID])
		REFERENCES [dbo].[tbl_Contact] ([ID])
		GO
		ALTER TABLE [dbo].[tbl_Company] CHECK CONSTRAINT [FK_CopmanyContactID]
		GO
		----3. [CompanyOfficialNameID]
		--ALTER TABLE [dbo].[tbl_Company]  WITH CHECK ADD  CONSTRAINT [FK_CompanyOfficialNameID] FOREIGN KEY([CompanyOfficialNameID])
		--REFERENCES [dbo].[...] ([ID])
		--GO
		--ALTER TABLE [dbo].[tbl_Company] CHECK CONSTRAINT [FK_CompanyOfficialNameID]
		--GO

-------------------------------------            /////////////////////////////////////////////////////////////////////////////////////
--4. [tbl_REFERENCES_RelationshipType]
ALTER TABLE [dbo].[tbl_Company]  WITH CHECK ADD  CONSTRAINT [FK_REFERENCES_RelationshipTypeID] FOREIGN KEY([RelationshipTypeID])
REFERENCES [dbo].[tbl_REFERENCES_RelationshipType] ([ID])
GO
ALTER TABLE [dbo].[tbl_Company] CHECK CONSTRAINT [FK_REFERENCES_RelationshipTypeID]
GO
--5. [tbl_REFERENCES_Field]
ALTER TABLE [dbo].[tbl_Company]  WITH CHECK ADD  CONSTRAINT [FK_FieldID] FOREIGN KEY([FieldID])
REFERENCES [dbo].[tbl_REFERENCES_Field] ([ID])
GO
ALTER TABLE [dbo].[tbl_Company] CHECK CONSTRAINT [FK_FieldID]
GO
--6. [tbl_REFERENCES_Field_Activity]
ALTER TABLE [dbo].[tbl_Company]  WITH CHECK ADD  CONSTRAINT [FK_FieldActivityID] FOREIGN KEY([FieldActivityID])
REFERENCES [dbo].[tbl_REFERENCES_Field_Activity] ([ID])
GO
ALTER TABLE [dbo].[tbl_Company] CHECK CONSTRAINT [FK_FieldActivityID]
GO
--7. [tbl_REFERENCES_Activity_Direction]
ALTER TABLE [dbo].[tbl_Company]  WITH CHECK ADD  CONSTRAINT [FK_ActivityDirectionID] FOREIGN KEY([ActivityDirectionID])
REFERENCES [dbo].[tbl_REFERENCES_Activity_Direction] ([ID])
GO
ALTER TABLE [dbo].[tbl_Company] CHECK CONSTRAINT [FK_ActivityDirectionID]
GO


-------------------------------------            /////////////////////////////////////////////////////////////////////////////////////
--8. [tbl_REFERENCES_AddressType]
ALTER TABLE [dbo].[tbl_Company]  WITH CHECK ADD  CONSTRAINT [FK_AddressTypeID] FOREIGN KEY([AddressTypeID])
REFERENCES [dbo].[tbl_REFERENCES_AddressType] ([ID])
GO
ALTER TABLE [dbo].[tbl_Company] CHECK CONSTRAINT [FK_AddressTypeID]
GO


--9. [tbl_REFERENCES_LOCATION_Continent]
ALTER TABLE [dbo].[tbl_Company]  WITH CHECK ADD  CONSTRAINT [FK_CompanyContinentID] FOREIGN KEY([ContinentID])
REFERENCES [dbo].[tbl_REFERENCES_LOCATION_Continent] ([ID])
GO
ALTER TABLE [dbo].[tbl_Company] CHECK CONSTRAINT [FK_CompanyContinentID]
GO
--10. [tbl_REFERENCES_LOCATION_Country]
ALTER TABLE [dbo].[tbl_Company]  WITH CHECK ADD  CONSTRAINT [FK_CompanyCountryID] FOREIGN KEY([CountryID])
REFERENCES [dbo].[tbl_REFERENCES_LOCATION_Country] ([ID])
GO
ALTER TABLE [dbo].[tbl_Company] CHECK CONSTRAINT [FK_CompanyCountryID]
GO
--11. [tbl_REFERENCES_LOCATION_State]
ALTER TABLE [dbo].[tbl_Company]  WITH CHECK ADD  CONSTRAINT [FK_CompanyStateID] FOREIGN KEY([StateID])
REFERENCES [dbo].[tbl_REFERENCES_LOCATION_State] ([ID])
GO
ALTER TABLE [dbo].[tbl_Company] CHECK CONSTRAINT [FK_CompanyStateID]
GO
--12. [tbl_REFERENCES_LOCATION_City]
ALTER TABLE [dbo].[tbl_Company]  WITH CHECK ADD  CONSTRAINT [FK_CompanyCityID] FOREIGN KEY([CityID])
REFERENCES [dbo].[tbl_REFERENCES_LOCATION_City] ([ID])
GO
ALTER TABLE [dbo].[tbl_Company] CHECK CONSTRAINT [FK_CompanyCityID]
GO

-------------------------------------            /////////////////////////////////////////////////////////////////////////////////////
--13. [[Communication_CellNumberTypeID]]
ALTER TABLE [dbo].[tbl_Company]  WITH CHECK ADD  CONSTRAINT [FK_CompanyCommunication_CellNumberTypeID] FOREIGN KEY([Communication_CellNumberTypeID])
REFERENCES [dbo].[tbl_REFERENCES_CommunicationType] ([ID])
GO
ALTER TABLE [dbo].[tbl_Company] CHECK CONSTRAINT [FK_CompanyCommunication_CellNumberTypeID]
GO
--14. [[Communication_PhoneNumberTypeID]]
ALTER TABLE [dbo].[tbl_Company]  WITH CHECK ADD  CONSTRAINT [FK_CompanyCommunication_PhoneNumberTypeID] FOREIGN KEY([Communication_PhoneNumberTypeID])
REFERENCES [dbo].[tbl_REFERENCES_CommunicationType] ([ID])
GO
ALTER TABLE [dbo].[tbl_Company] CHECK CONSTRAINT [FK_CompanyCommunication_PhoneNumberTypeID]
GO
--15. [[Communication_FaxNumberTypeID]]
ALTER TABLE [dbo].[tbl_Company]  WITH CHECK ADD  CONSTRAINT [FK_CompanyCommunication_FaxNUmberTypeID] FOREIGN KEY([Communication_FaxNumberTypeID])
REFERENCES [dbo].[tbl_REFERENCES_CommunicationType] ([ID])
GO
ALTER TABLE [dbo].[tbl_Company] CHECK CONSTRAINT [FK_CompanyCommunication_FaxNumberTypeID]
GO
--16. [[Communication_EmailTypeID]]
ALTER TABLE [dbo].[tbl_Company]  WITH CHECK ADD  CONSTRAINT [FK_CompanyCommunication_EmailTypeID] FOREIGN KEY([Communication_EmailTypeID])
REFERENCES [dbo].[tbl_REFERENCES_CommunicationType] ([ID])
GO
ALTER TABLE [dbo].[tbl_Company] CHECK CONSTRAINT [FK_CompanyCommunication_EmailTypeID]
GO
--17. [[Communication_WebTypeID]]
ALTER TABLE [dbo].[tbl_Company]  WITH CHECK ADD  CONSTRAINT [FK_CompanyCommunication_WebTypeID] FOREIGN KEY([Communication_WebTypeID])
REFERENCES [dbo].[tbl_REFERENCES_CommunicationType] ([ID])
GO
ALTER TABLE [dbo].[tbl_Company] CHECK CONSTRAINT [FK_CompanyCommunication_WebTypeID]
GO





USE [ERP]
GO

INSERT INTO [dbo].[tbl_Company]
           ([ID]
           ,[CreatedOn]
           ,[CreatedByID]
           ,[ModifiedOn]
           ,[ModifiedByID]
		   ,[ResponsibleUserID]
           ,[CompanyShortName]
           ,[ContactID]
           ,[RelationshipTypeID]
           ,[FieldID]
           ,[FieldActivityID]
           ,[ActivityDirectionID]
           ,[AddressTypeID]
           ,[ContinentID]
           ,[CountryID]
           ,[StateID]
           ,[CityID]
           ,[ZIP]
           ,[Communication_CellNumber]
           ,[Communication_PhoneNumber]
           ,[Communication_FaxNumber]
           ,[Communication_Email]
           ,[Communication_Web]
           ,[CountryPhoneCodeID]
           ,[Communication_CellNumberTypeID]
           ,[Communication_PhoneNumberTypeID]
           ,[Communication_FaxNumberTypeID]
           ,[Communication_EmailTypeID]
           ,[Communication_WebTypeID]
           ,[Active]
           ,[Description])
     VALUES
           
		   
		   
		   
		   (default,--<ID, uniqueidentifier,>
           default,--CreatedOn, datetime,>
           default,--CreatedByID, uniqueidentifier,>
           default,--ModifiedOn, datetime,>
           default,--ModifiedByID, uniqueidentifier,>
		   (select [ID] from [dbo].[tbl_Users] where Name = 'Andrew'),--[ResponsibleUserID] uniqueidentifier,>
		   'Network LLC',--CompanyShortName, nvarchar(35),>
           default,--ContactID, uniqueidentifier,>
           (select [ID] from [dbo].[tbl_REFERENCES_RelationshipType] where [Name] = 'Постачальник'),--RelationshipTypeID, uniqueidentifier,>
           (select [ID] from [dbo].[tbl_REFERENCES_Field] where [Name] = 'Виробництво'),--FieldID, uniqueidentifier,>
           (select [ID] from [dbo].[tbl_REFERENCES_Field_Activity] where [Name] = 'Продукти'),--FieldActivityID, uniqueidentifier,>
           (select [ID] from [dbo].[tbl_REFERENCES_Activity_Direction] where ID = '29A2E6EF-6DE8-42AF-87E5-CDC71517AD91'),--ActivityDirectionID, uniqueidentifier,>
           (select [ID] from [dbo].[tbl_REFERENCES_AddressType] where ID = 'FBF193F3-11BD-4B9B-9B88-910A8B47A7A2'),--AddressTypeID, uniqueidentifier,>
           (select [ID] from [dbo].[tbl_REFERENCES_LOCATION_Continent] where [Name_En] = 'Europe'),--ContinentID, uniqueidentifier,>
           (select [ID] from [dbo].[tbl_REFERENCES_LOCATION_Country] where [Name_En] = 'Ukraine'),--CountryID, uniqueidentifier,>
           default,--(select [ID] from [dbo].[tbl_REFERENCES_LOCATION_State] where [[Name_En]] = 'ЛПР'),--StateID, uniqueidentifier,>
           default,--(select [ID] from [dbo].[tbl_REFERENCES_LOCATION_City] where [[Name_En]] = 'ЛПР'),--CityID, uniqueidentifier,>
           '',--ZIP, nvarchar(20),>
           '(095) 147-24-88',--Communication_CellNumber, nvarchar(15),>
           '(095) 147-24-88',--Communication_PhoneNumber, nvarchar(15),>
           '(095) 147-24-88',--Communication_FaxNumber, nvarchar(15),>
           'test@gmail.tom',--Communication_Email, nvarchar(44),>
           'test.comua',--Communication_Web, nvarchar(44),>
           (select [ID] from [dbo].[tbl_REFERENCES_LOCATION_Country] where [PhoneCode] = '380'),--CountryPhoneCodeID, uniqueidentifier,>
           default,--Communication_CellNumberTypeID, uniqueidentifier,>
           default,--Communication_PhoneNumberTypeID, uniqueidentifier,>
           default,--Communication_FaxNumberTypeID, uniqueidentifier,>
           default,--Communication_EmailTypeID, uniqueidentifier,>
           default,--Communication_WebTypeID, uniqueidentifier,>
           default,--Active, bit,>
           ''--Description--, nvarchar(250),>
		   )
GO

select * from [dbo].[tbl_Company]



select [dbo].[tbl_Company].[CompanyShortName]
from [ERP].[dbo].[tbl_Company]
join  [dbo].[tbl_Users] on  [dbo].[tbl_Company].[ResponsibleUserID] = [dbo].[tbl_Users].[ID] 

where [dbo].[tbl_Users].[Name]= 'Michael'


SELECT TOP 200       dbo.tbl_Company.CreatedOn, dbo.tbl_Users.Name AS ResponsibleUser,dbo.tbl_Company.[CompanyShortName],
				dbo.tbl_Contact.ContactLName  + ' ' + dbo.tbl_Contact.ContactFName + ' ' + dbo.tbl_Contact.ContactMName AS ContactName,
				tbl_REFERENCES_RelationshipType.Name AS Relationship,
				[dbo].[tbl_REFERENCES_Field].Name AS Field,
				[dbo].[tbl_REFERENCES_Field_Activity].Name  AS FieldActivity,
				[dbo].[tbl_REFERENCES_Activity_Direction].Name AS ActivityDirection,
				[dbo].[tbl_REFERENCES_AddressType].Name As AddressType,
				[dbo].[tbl_REFERENCES_LOCATION_Continent].Name_En As Continent,
				[dbo].[tbl_REFERENCES_LOCATION_Country].Name_En As Country,
				--[dbo].[tbl_REFERENCES_LOCATION_State].Name As StateName
				--[dbo].[tbl_REFERENCES_LOCATION_City].Name As City
				dbo.tbl_Company.[ZIP],
				dbo.tbl_Company.[Communication_CellNumber],
				dbo.tbl_Company.[Communication_PhoneNumber],
				dbo.tbl_Company.[Communication_FaxNumber],
				dbo.tbl_Company.[Communication_Email],
				dbo.tbl_Company.[Communication_Web],
				dbo.tbl_Company.[Active]

FROM            dbo.tbl_Company 

				INNER JOIN dbo.tbl_Users ON dbo.tbl_Company.[ResponsibleUserID] = dbo.tbl_Users.ID
				INNER JOIN [dbo].[tbl_Contact] ON dbo.tbl_Company.[ContactID] = dbo.tbl_Contact.ID
                INNER JOIN dbo.tbl_REFERENCES_RelationshipType ON dbo.tbl_Company.[RelationshipTypeID] = dbo.tbl_REFERENCES_RelationshipType.ID 
				INNER JOIN dbo.[tbl_REFERENCES_Field] ON dbo.tbl_Company.[FieldID] = dbo.[tbl_REFERENCES_Field].ID 
				
				INNER JOIN dbo.[tbl_REFERENCES_Field_Activity] ON dbo.tbl_Company.[FieldActivityID] = dbo.[tbl_REFERENCES_Field_Activity].ID 
				INNER JOIN dbo.[tbl_REFERENCES_Activity_Direction] ON dbo.tbl_Company.[ActivityDirectionID] = dbo.[tbl_REFERENCES_Activity_Direction].ID 
				INNER JOIN dbo.[tbl_REFERENCES_AddressType] ON dbo.tbl_Company.[AddressTypeID] = dbo.[tbl_REFERENCES_AddressType].ID 
				INNER JOIN dbo.[tbl_REFERENCES_LOCATION_Continent] ON dbo.tbl_Company.[ContinentID] = dbo.[tbl_REFERENCES_LOCATION_Continent].ID 
				INNER JOIN dbo.[tbl_REFERENCES_LOCATION_Country] ON dbo.tbl_Company.[CountryID] = dbo.[tbl_REFERENCES_LOCATION_Country].ID 
				--INNER JOIN dbo.[tbl_REFERENCES_LOCATION_State] ON dbo.tbl_Company.[StateID] = dbo.[tbl_REFERENCES_LOCATION_State].ID 
				--INNER JOIN dbo.[tbl_REFERENCES_LOCATION_City] ON dbo.tbl_Company.[CityID] = dbo.[tbl_REFERENCES_LOCATION_City].ID 