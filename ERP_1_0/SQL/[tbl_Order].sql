USE [ERP]
GO

/****** Object:  Table [dbo].[tbl_Order]    Script Date: 24.08.2021 2:42:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Order](
	[ID] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedByID] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedByID] [uniqueidentifier] NULL,
	[InvoiceNumber] [nvarchar](250) NULL,
	[ResponsibleUserID] [uniqueidentifier] NULL,
	[CompanyID] [uniqueidentifier] NULL,
	[OrderDocumentStateTypeID] [uniqueidentifier] NULL,
	[SumNoVAT] [money] NULL,
	[SumVAT] [money] NULL,
	[OrderBillStateTypeID] [uniqueidentifier] NULL,
	[DeliveryStateTypeID] [uniqueidentifier] NULL
	)
GO

-----------DEFAULT VALUES AND CHECKS
	ALTER TABLE [dbo].[tbl_Order] 
	ADD  CONSTRAINT [PDFOrderID]  
	DEFAULT (newid()) FOR [ID]
	--2.[CreatedOn]
	ALTER TABLE [dbo].[tbl_Order] 
	ADD  CONSTRAINT [DF_tbl_Order_CreatedOn]  
	DEFAULT (getdate()) FOR [CreatedOn]

	Go
-----------TRIGGERS
CREATE TRIGGER trg_Order_ModifiedOn
ON [dbo].[tbl_Order]
AFTER UPDATE
AS
UPDATE [dbo].[tbl_Order]
SET [ModifiedOn] = CURRENT_TIMESTAMP
WHERE [ID] IN (SELECT DISTINCT [ID] FROM inserted);
GO

----------KEYS


--1. PRIMARY KEY 
Alter table [tbl_Order]
ADD CONSTRAINT PK_tbl_Order_ID
PRIMARY KEY ([ID])
GO


	--2. [tbl_User]
				ALTER TABLE [dbo].[tbl_Order]  WITH CHECK ADD  CONSTRAINT [FK_OrderResponsibleUserID] FOREIGN KEY([ResponsibleUserID])
				REFERENCES [dbo].[tbl_Users] ([ID])
				GO
				ALTER TABLE [dbo].[tbl_Order] CHECK CONSTRAINT [FK_OrderResponsibleUserID]
			GO
	------2.1 [tbl_Company]
				ALTER TABLE [dbo].[tbl_Order]  WITH CHECK ADD  CONSTRAINT [FK_OrderCopmanyID] FOREIGN KEY([CompanyID])
				REFERENCES [dbo].[tbl_Company] ([ID])
				GO
				ALTER TABLE [dbo].[tbl_Order] CHECK CONSTRAINT [FK_OrderCopmanyID]
				GO
	------2.1 [OrderDocumentStateTypeID]
				ALTER TABLE [dbo].[tbl_Order]  WITH CHECK ADD  CONSTRAINT [FK_REFERENCES_ORDER_DocumentStateTypeID] FOREIGN KEY([OrderDocumentStateTypeID])
				REFERENCES [dbo].[tbl_REFERENCES_ORDER_DocumentStateType] ([ID])
				GO
				ALTER TABLE [dbo].[tbl_Order] CHECK CONSTRAINT [FK_REFERENCES_ORDER_DocumentStateTypeID]
				GO
	------2.1 [OrderBillStateTypeID]
				ALTER TABLE [dbo].[tbl_Order]  WITH CHECK ADD  CONSTRAINT [FK_REFERENCES_ORDER_BillStateTypeID] FOREIGN KEY([OrderBillStateTypeID])
				REFERENCES [dbo].[tbl_REFERENCES_ORDER_BillStateType] ([ID])
				GO
				ALTER TABLE [dbo].[tbl_Order] CHECK CONSTRAINT [FK_REFERENCES_ORDER_BillStateTypeID]
				GO
					------2.1 [tbl_Company]
				ALTER TABLE [dbo].[tbl_Order]  WITH CHECK ADD  CONSTRAINT [FK_REFERENCES_DELIVERY_StateTypeID] FOREIGN KEY([DeliveryStateTypeID])
				REFERENCES [dbo].[tbl_REFERENCES_DELIVERY_StateType] ([ID])
				GO
				ALTER TABLE [dbo].[tbl_Order] CHECK CONSTRAINT [FK_REFERENCES_DELIVERY_StateTypeID]
				GO



GO

INSERT INTO [dbo].[tbl_Order]
           ([ID]
           ,[CreatedOn]
           ,[CreatedByID]
           ,[ModifiedOn]
           ,[ModifiedByID]
           ,[InvoiceNumber]
           ,[ResponsibleUserID]
           ,[CompanyID]
           ,[OrderDocumentStateTypeID]
           ,[SumNoVAT] 
			,[SumVAT] 
           ,[OrderBillStateTypeID]
           ,[DeliveryStateTypeID])
     VALUES
           (default,--<ID, uniqueidentifier,>
           default,--,<CreatedOn, datetime,>
           default,--,<CreatedByID, uniqueidentifier,>
           default,--,<ModifiedOn, datetime,>
           default,--,<ModifiedByID, uniqueidentifier,>
           'I-1',--InvoiceNumber, nvarchar(250),>
           (select [ID] from [dbo].[tbl_Users] where Name = 'Michael'),--[ResponsibleUserID] uniqueidentifier,>
           (select [ID] from [dbo].[tbl_Company] where [CompanyShortName] = 'New company'),--CompanyID, uniqueidentifier,>
           (select [ID] from [dbo].[tbl_REFERENCES_ORDER_DocumentStateType] where [Name] = 'Відправлено'),--,<OrderDocumentStateTypeID, uniqueidentifier,>
           '',--SELECT        sum(Qty)  FROM [ShopDB].[dbo].[OrderDetails] group by [LineItem]--,<[SumNoVAT], money,>
		   '',--SELECT        sum(Qty)  FROM [ShopDB].[dbo].[OrderDetails] group by [LineItem]--,<[SumVAT], money,>
           (select [ID] from [dbo].[tbl_REFERENCES_ORDER_BillStateType] where [Name] = 'Оплачено'),--<OrderBillStateTypeID, uniqueidentifier,>
           (select [ID] from [dbo].[tbl_REFERENCES_DELIVERY_StateType] where [Name] = 'Відправлено')--,<DeliveryStateTypeID, uniqueidentifier,>
		   )
GO



select * from [dbo].[tbl_Order] 

--select [dbo].[tbl_Company].[CompanyShortName]
--from [ERP].[dbo].[tbl_Order]
--join  [dbo].[tbl_Company] on  [dbo].[tbl_Order].[CompanyID] = [dbo].[tbl_Company].[ID]

--where [dbo].[tbl_Order].[ResponsibleUserID]= '8364D926-3798-44E3-8E73-A796F62BEC6E'