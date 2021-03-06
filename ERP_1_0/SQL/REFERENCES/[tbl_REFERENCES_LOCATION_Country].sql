/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[CreatedOn]
      ,[CreatedByID]
      ,[ModifiedOn]
      ,[ModifiedByID]
      ,[ISO-3166 alpha2]
      ,[ISO-3166 alpha3]
      ,[ISO-3166 numeric]
      ,[fips]
      ,[Name_Ukr]
      ,[Name_Ru]
      ,[Name_En]
      ,[Capital]
      ,[Area in km²]
      ,[Population]
      ,[ContinentID]
      ,[Description]
  FROM [ERP].[dbo].[tbl_REFERENCES_LOCATION_Country]


  
  update [tbl_REFERENCES_LOCATION_Country]
  set [ContinentID] = 'A55127A1-35BA-4EB6-8C10-AD74F30AEE75' where [Description] = 'OC'

