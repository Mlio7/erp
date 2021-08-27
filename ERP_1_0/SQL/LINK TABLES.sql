------2. [tbl_Company]
----			ALTER TABLE [dbo].[tbl_Contact]  WITH CHECK ADD  CONSTRAINT [FK_ContactCopmanyID] FOREIGN KEY([CompanyID])
----			REFERENCES [dbo].[tbl_Company] ([ID])
----			GO
----			ALTER TABLE [dbo].[tbl_Contact] CHECK CONSTRAINT [FK_ContactCopmanyID]
----			GO




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