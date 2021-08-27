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

USE ERP

-- check to see if table exists in sys.tables - ignore DROP TABLE if it does not
IF EXISTS(SELECT * 
		  FROM sys.tables 
		  WHERE SCHEMA_NAME(schema_id) LIKE 'dbo' AND name like 'tbl_Contact')  
   DROP TABLE [dbo].[tbl_Contact];  
GO

--EXEC sp_fkeys [tbl_Contact]

create table [tbl_Contact]
(
	[ID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedByID] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedByID] [uniqueidentifier] NULL,
	[ResponsibleUserID] [uniqueidentifier] NULL,
	[CompanyID] [uniqueidentifier] NULL,
	[ContactLName] [nvarchar](35) NOT NULL,
	[ContactFName] [nvarchar](35) NULL,
	[ContactMName] [nvarchar](35) NULL,
	[Birthdate] datetime NULL ,
	[SalutationID] [uniqueidentifier] NULL,
	[RelationshipTypeID][uniqueidentifier] NULL,
	[DepartmentID] [uniqueidentifier] NULL,
	[JobID] [uniqueidentifier] NULL,
	[DesicionRoleID][uniqueidentifier] NULL,
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
	[Active] BIT NOT NULL CONSTRAINT [DF_tbl_Contact_Active] DEFAULT 1,
	[Description] [nvarchar](250) NULL,
	[Photo] [image] NULL
)

--DEFAULT VALUES AND CHECKS
	ALTER TABLE [dbo].[tbl_Contact] 
	ADD  CONSTRAINT [PDFContactID]  
	DEFAULT (newid()) FOR [ID]
	--2.[CellNumber]
	ALTER TABLE [dbo].[tbl_Contact] 
	ADD  CONSTRAINT [DF_tbl_Contact_CreatedOn]  
	DEFAULT (getdate()) FOR [CreatedOn]
	--3.[CellNumber]
	ALTER TABLE [dbo].[tbl_Contact]  
	WITH CHECK ADD  CONSTRAINT [CK__tbl_Contact__REGEXCHECK_CellNumber] 
	CHECK  (([Communication_CellNumber] like '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'))
			ALTER TABLE [dbo].[tbl_Contact]  
			ADD  CONSTRAINT [CK__tbl_Contact__DEFAULT_Communication_CellNumberTypeID] 
			DEFAULT  'FA08FC2A-9D55-40C9-9576-0017EAED3E49' for [Communication_CellNumberTypeID]
	--4.[PhoneNumber]
	ALTER TABLE [dbo].[tbl_Contact]  
	WITH CHECK ADD  CONSTRAINT [CK__tbl_Contact__REGEXCHECK_PhoneNumber] 
	CHECK (([Communication_PhoneNumber] like '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'))
			ALTER TABLE [dbo].[tbl_Contact]  
			ADD  CONSTRAINT [CK__tbl_Contact__DEFAULT_Communication_PhoneNumberTypeID] 
			DEFAULT  'DBCB6A43-D99F-45AE-9B41-037DE595242E' for [Communication_PhoneNumberTypeID]
	--5.[FaxNumber]
	ALTER TABLE [dbo].[tbl_Contact]  
	WITH CHECK ADD  CONSTRAINT [CK__tbl_Contact__REGEXCHECK_FaxNumber] 
	CHECK (([Communication_FaxNumber] like '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'))
			ALTER TABLE [dbo].[tbl_Contact]  
			ADD  CONSTRAINT [CK__tbl_Contact__DEFAULT_Communication_FaxNumberTypeID] 
			DEFAULT  '82696D8B-71AE-4BA4-94FD-3F77474D74E7' for [Communication_FaxNumberTypeID]
	--6.[Email]
	ALTER TABLE [dbo].[tbl_Contact]  
	WITH CHECK ADD  CONSTRAINT [CK__tbl_Contact__REGEXCHECK_Email] 
	CHECK (([Communication_Email] like '[a-z]%@%[a-z]%.%'))
			ALTER TABLE [dbo].[tbl_Contact]  
			ADD  CONSTRAINT [CK__tbl_Contact__DEFAULT_Communication_EmailTypeID] 
			DEFAULT  '7A628D16-D7D0-4979-B8BA-B64EF54A0366' for [Communication_EmailTypeID]
	--7.[Web]
	ALTER TABLE [dbo].[tbl_Contact]  
	WITH CHECK ADD  CONSTRAINT [CK__tbl_Contact__REGEXCHECK_Web] 
	CHECK (([Communication_Web] like '[a-z]%.%[a-z\.]%'))
			ALTER TABLE [dbo].[tbl_Contact]  
			ADD  CONSTRAINT [CK__tbl_Contact__DEFAULT_Communication_WebType] 
			DEFAULT  '7B77F07B-9976-47D6-95AA-D161FF369D6D' for [Communication_WebTypeID]
Go
-----------TRIGGERS
CREATE TRIGGER trg_Contact_ModifiedOn
ON [dbo].[tbl_Contact]
AFTER UPDATE
AS
UPDATE [dbo].[tbl_Contact]
SET [ModifiedOn] = CURRENT_TIMESTAMP
WHERE [ID] IN (SELECT DISTINCT [ID] FROM inserted);
GO

----------KEYS


--1. PRIMARY KEY 
Alter table [tbl_Contact]
ADD CONSTRAINT PK_tbl_Contact_ID
PRIMARY KEY ([ID])
GO

	------2. [tbl_Company]
	----			ALTER TABLE [dbo].[tbl_Contact]  WITH CHECK ADD  CONSTRAINT [FK_ContactResponsibleUserD] FOREIGN KEY([ResponsibleUserID])
	----			REFERENCES [dbo].[tbl_Users] ([ID])
	----			GO
	----			ALTER TABLE [dbo].[tbl_Contact] CHECK CONSTRAINT [FK_ContactCopmanyID]
	----			GO
	------2.1 [tbl_Company]
	----			ALTER TABLE [dbo].[tbl_Contact]  WITH CHECK ADD  CONSTRAINT [FK_ContactCopmanyID] FOREIGN KEY([CompanyID])
	----			REFERENCES [dbo].[tbl_Company] ([ID])
	----			GO
	----			ALTER TABLE [dbo].[tbl_Contact] CHECK CONSTRAINT [FK_ContactCopmanyID]
	----			GO
-----------------------------------------------------
--3. [tbl_REFERENCES_CONTACT_Salutation]
ALTER TABLE [dbo].[tbl_Contact]  WITH CHECK ADD  CONSTRAINT [FK_ContactSalutationID] FOREIGN KEY([SalutationID])
REFERENCES [dbo].[tbl_REFERENCES_CONTACT_Salutation] ([ID])
GO
ALTER TABLE [dbo].[tbl_Contact] CHECK CONSTRAINT [FK_ContactSalutationID]
GO
--4. [tbl_REFERENCES_RelationshipType]
ALTER TABLE [dbo].[tbl_Contact]  WITH CHECK ADD  CONSTRAINT [FK_ContactRelationshipTypeID] FOREIGN KEY([RelationshipTypeID])
REFERENCES [dbo].[tbl_REFERENCES_RelationshipType] ([ID])
GO
ALTER TABLE [dbo].[tbl_Contact] CHECK CONSTRAINT [FK_ContactRelationshipTypeID]
GO
--5. [tbl_REFERENCES_COMPANY_Department]
ALTER TABLE [dbo].[tbl_Contact]  WITH CHECK ADD  CONSTRAINT [FK_ContactDepartmentID] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[tbl_REFERENCES_COMPANY_Department] ([ID])
GO
ALTER TABLE [dbo].[tbl_Contact] CHECK CONSTRAINT [FK_ContactDepartmentID]
GO
--6. [tbl_REFERENCES_CONTACT_Job]
ALTER TABLE [dbo].[tbl_Contact]  WITH CHECK ADD  CONSTRAINT [FK_ContactJobID] FOREIGN KEY([JobID])
REFERENCES [dbo].[tbl_REFERENCES_CONTACT_Job] ([ID])
GO
ALTER TABLE [dbo].[tbl_Contact] CHECK CONSTRAINT [FK_ContactJobID]
GO
--7. [tbl_REFERENCES_CONTACT_DecisionRole]
ALTER TABLE [dbo].[tbl_Contact]  WITH CHECK ADD  CONSTRAINT [FK_ContactDecisionRoleID] FOREIGN KEY([DesicionRoleID])
REFERENCES [dbo].[tbl_REFERENCES_CONTACT_DecisionRole] ([ID])
GO
ALTER TABLE [dbo].[tbl_Contact] CHECK CONSTRAINT [FK_ContactDecisionRoleID]
GO
---------------------------------------------------------
--8. [tbl_REFERENCES_LOCATION_Continent]
ALTER TABLE [dbo].[tbl_Contact]  WITH CHECK ADD  CONSTRAINT [FK_ContactContinentID] FOREIGN KEY([ContinentID])
REFERENCES [dbo].[tbl_REFERENCES_LOCATION_Continent] ([ID])
GO
ALTER TABLE [dbo].[tbl_Contact] CHECK CONSTRAINT [FK_ContactContinentID]
GO
--9. [tbl_REFERENCES_LOCATION_Country]
ALTER TABLE [dbo].[tbl_Contact]  WITH CHECK ADD  CONSTRAINT [FK_ContactCountryID] FOREIGN KEY([CountryID])
REFERENCES [dbo].[tbl_REFERENCES_LOCATION_Country] ([ID])
GO
ALTER TABLE [dbo].[tbl_Contact] CHECK CONSTRAINT [FK_ContactCountryID]
GO
--10. [tbl_REFERENCES_LOCATION_State]
ALTER TABLE [dbo].[tbl_Contact]  WITH CHECK ADD  CONSTRAINT [FK_ContactStateID] FOREIGN KEY([StateID])
REFERENCES [dbo].[tbl_REFERENCES_LOCATION_State] ([ID])
GO
ALTER TABLE [dbo].[tbl_Contact] CHECK CONSTRAINT [FK_ContactStateID]
GO
--11. [tbl_REFERENCES_LOCATION_City]
ALTER TABLE [dbo].[tbl_Contact]  WITH CHECK ADD  CONSTRAINT [FK_ContactCityID] FOREIGN KEY([CityID])
REFERENCES [dbo].[tbl_REFERENCES_LOCATION_City] ([ID])
GO
ALTER TABLE [dbo].[tbl_Contact] CHECK CONSTRAINT [FK_ContactCityID]
GO
------------------------------------------------------------

--12. [tbl_REFERENCES_CountryPhoneCode]
ALTER TABLE [dbo].[tbl_Contact]  WITH CHECK ADD  CONSTRAINT [FK_CountryPhoneCodeID] FOREIGN KEY([CountryPhoneCodeID])
REFERENCES [dbo].[tbl_REFERENCES_LOCATION_Country] ([ID])
GO
ALTER TABLE [dbo].[tbl_Contact] CHECK CONSTRAINT [FK_CountryPhoneCodeID]
GO
--13. [[Communication_CellNumberTypeID]]
ALTER TABLE [dbo].[tbl_Contact]  WITH CHECK ADD  CONSTRAINT [FK_ContactCommunication_CellNumberTypeID] FOREIGN KEY([Communication_CellNumberTypeID])
REFERENCES [dbo].[tbl_REFERENCES_CommunicationType] ([ID])
GO
ALTER TABLE [dbo].[tbl_Contact] CHECK CONSTRAINT [FK_ContactCommunication_CellNumberTypeID]
GO
--14. [[Communication_PhoneNumberTypeID]]
ALTER TABLE [dbo].[tbl_Contact]  WITH CHECK ADD  CONSTRAINT [FK_ContactCommunication_PhoneNumberTypeID] FOREIGN KEY([Communication_PhoneNumberTypeID])
REFERENCES [dbo].[tbl_REFERENCES_CommunicationType] ([ID])
GO
ALTER TABLE [dbo].[tbl_Contact] CHECK CONSTRAINT [FK_ContactCommunication_PhoneNumberTypeID]
GO
--15. [[Communication_FaxNumberTypeID]]
ALTER TABLE [dbo].[tbl_Contact]  WITH CHECK ADD  CONSTRAINT [FK_ContactCommunication_FaxNUmberTypeID] FOREIGN KEY([Communication_FaxNumberTypeID])
REFERENCES [dbo].[tbl_REFERENCES_CommunicationType] ([ID])
GO
ALTER TABLE [dbo].[tbl_Contact] CHECK CONSTRAINT [FK_ContactCommunication_FaxNumberTypeID]
GO
--16. [[Communication_EmailTypeID]]
ALTER TABLE [dbo].[tbl_Contact]  WITH CHECK ADD  CONSTRAINT [FK_ContactCommunication_EmailTypeID] FOREIGN KEY([Communication_EmailTypeID])
REFERENCES [dbo].[tbl_REFERENCES_CommunicationType] ([ID])
GO
ALTER TABLE [dbo].[tbl_Contact] CHECK CONSTRAINT [FK_ContactCommunication_EmailTypeID]
GO
--17. [[Communication_WebTypeID]]
ALTER TABLE [dbo].[tbl_Contact]  WITH CHECK ADD  CONSTRAINT [FK_ContactCommunication_WebTypeID] FOREIGN KEY([Communication_WebTypeID])
REFERENCES [dbo].[tbl_REFERENCES_CommunicationType] ([ID])
GO
ALTER TABLE [dbo].[tbl_Contact] CHECK CONSTRAINT [FK_ContactCommunication_WebTypeID]
GO

INSERT INTO [dbo].[tbl_Contact]
           ([ID]
           ,[CreatedOn]
           ,[CreatedByID]
           ,[ModifiedOn]
           ,[ModifiedByID]
		   ,[ResponsibleUserID]
           ,[CompanyID]
           ,[ContactLName]
           ,[ContactFName]
           ,[ContactMName]
           ,[Birthdate]
           ,[SalutationID]
           ,[RelationshipTypeID]
           ,[DepartmentID]
           ,[JobID]
           ,[DesicionRoleID]
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
           ,[Description]
           ,[Photo])
     VALUES
           (
		   default,--<ID, uniqueidentifier,>
           default,--CreatedOn, datetime,>
           default,--CreatedByID, uniqueidentifier,>
           default,--ModifiedOn, datetime,>
           default,--ModifiedByID, uniqueidentifier,>
		   (select [ID] from [dbo].[tbl_Users] where Name = 'Michael'),--[ResponsibleUserID] uniqueidentifier,>
           default,--CompanyID, uniqueidentifier,>
           'Когут',--ContactLName, nvarchar(35),>
           'Марія',--ContactFName, nvarchar(35),>
           'Романівна',--ContactMName, nvarchar(35),>
           '1992-08-22',--Birthdate, datetime,>
           (select [ID] from [dbo].[tbl_REFERENCES_CONTACT_Salutation] where ID = 'A9AB3F24-E326-474E-80E2-7A3E1838620F'),--SalutationID, uniqueidentifier,>
           (select [ID] from [dbo].[tbl_REFERENCES_RelationshipType] where [Name] = 'Постачальник'),--RelationshipTypeID, uniqueidentifier,>
           (select [ID] from [dbo].[tbl_REFERENCES_COMPANY_Department] where [Name] = 'Маркетинг'),--DepartmentID, uniqueidentifier,>
           (select [ID] from [dbo].[tbl_REFERENCES_CONTACT_Job] where [Name] = 'Маркетолог'),--JobID, uniqueidentifier,>
           (select [ID] from [dbo].[tbl_REFERENCES_CONTACT_DecisionRole] where [Name] = 'ЛПР'),--DesicionRoleID, uniqueidentifier,>
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
           default,--Description, nvarchar(250),>
           default--Photo, image,>
		   )
		   GO
select * from [dbo].[tbl_Contact]
GO


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
		----2. [tbl_Company]
		--ALTER TABLE [dbo].[tbl_Company]  WITH CHECK ADD  CONSTRAINT [FK_CopmanyContactID] FOREIGN KEY([ContactID])
		--REFERENCES [dbo].[tbl_Contact] ([ID])
		--GO
		--ALTER TABLE [dbo].[tbl_Company] CHECK CONSTRAINT [FK_CopmanyContactID]
		--GO
		--3. [CompanyOfficialNameID]
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
REFERENCES [dbo].[tbl_REFERENCES_Field_Activity] ([ID])
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
		   (select [ID] from [dbo].[tbl_Users] where Name = 'Michael'),--[ResponsibleUserID] uniqueidentifier,>
		   'New company',--CompanyShortName, nvarchar(35),>
           default,--ContactID, uniqueidentifier,>
           (select [ID] from [dbo].[tbl_REFERENCES_RelationshipType] where [Name] = 'Постачальник'),--RelationshipTypeID, uniqueidentifier,>
           (select [ID] from [dbo].[tbl_REFERENCES_Field] where [Name] = 'Виробництво'),--FieldID, uniqueidentifier,>
           (select [ID] from [dbo].[tbl_REFERENCES_Field_Activity] where [Name] = 'Продукти'),--FieldActivityID, uniqueidentifier,>
           (select [ID] from [dbo].[tbl_REFERENCES_Activity_Direction] where [Name] = 'Продукти'),--ActivityDirectionID, uniqueidentifier,>
           (select [ID] from [dbo].[tbl_REFERENCES_AddressType] where [Name] = 'Адрес доставки'),--AddressTypeID, uniqueidentifier,>
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