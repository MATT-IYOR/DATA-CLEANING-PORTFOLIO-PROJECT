SELECT *
  FROM [SQL_PROJECT_DATA CLEANING].[dbo].[NashvilleHousing]

 SELECT CHARINDEX(',',PropertyAddress),PropertyAddress FROM [SQL_PROJECT_DATA CLEANING].[dbo].[NashvilleHousing]

 SELECT CAST(SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)AS VARCHAR)FROM [SQL_PROJECT_DATA CLEANING].[dbo].[NashvilleHousing]

 --1. Row count check

 SELECT COUNT(*) 
	FROM [SQL_PROJECT_DATA CLEANING].[dbo].[NashvilleHousing]


 --2. Column count check using information schemes

 SELECT 
	COUNT(*) as Column_count 
 
 FROM 
	INFORMATION_SCHEMA.COLUMNS 
 
 WHERE 
	TABLE_NAME='[SQL_PROJECT_DATA CLEANING].[dbo].[NashvilleHousing]'


--Data type check

SELECT COLUMN_NAME,DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
	 

SELECT COLUMN_NAME,DATA_TYPE
 
 FROM 
	INFORMATION_SCHEMA.COLUMNS 
 
 WHERE 
	TABLE_NAME='[SQL_PROJECT_DATA CLEANING].[dbo].[NashvilleHousing]'

--STANDERDIZING DATE FORMAT 

SELECT SaleDateConverted,CONVERT(Date,SaleDate)
	FROM [SQL_PROJECT_DATA CLEANING].[dbo].[NashvilleHousing]

--Duplicate check

SELECT PropertyAddress,SaleDateConverted,OwnerAddress,SalePrice,LegalReference,
	COUNT(*) as Duplicate_Count
	FROM [SQL_PROJECT_DATA CLEANING].[dbo].[NashvilleHousing]

Group by PropertyAddress,SaleDateConverted,OwnerAddress,SalePrice,LegalReference

HAVING COUNT(*) > 1

--IDENTIFYING DUPLICATES

--WITH DuplicateCTE AS(
--SELECT PropertyAddress,SaleDateConverted,OwnerAddress,SalePrice,LegalReference,
--	COUNT(*) as Duplicate_Count
--	FROM [SQL_PROJECT_DATA CLEANING].[dbo].[NashvilleHousing]

--Group by PropertyAddress,SaleDateConverted,OwnerAddress,SalePrice,LegalReference

--HAVING COUNT(*) > 1
--)

--SELECT*
--	FROM DuplicateCTE


--DELETING DUPLICATES 

WITH DuplicateCTE AS(
SELECT*,
	ROW_NUMBER() OVER (Partition by
	PropertyAddress,
	SaleDateConverted,
	OwnerAddress,
	SalePrice,   
	LegalReference 
	order by OwnerAddress) Duplicate_Count
	FROM [SQL_PROJECT_DATA CLEANING].[dbo].[NashvilleHousing]
	)
DELETE
	FROM DuplicateCTE
	where Duplicate_Count>1



--DROP TABLE IF EXISTS #TEMP_Duplicate
--CREATE TABLE #TEMP_Duplicate(
--PropertyAddress varchar,
--SaleDateConverted DATE,
--OwnerAddress nvarchar,
--SalePrice int,
--LegalReference nvarchar 
--)

--INSERT INTO #TEMP_Duplicate
--SELECT PropertyAddress,SaleDateConverted,OwnerAddress,SalePrice,LegalReference,
--	COUNT(*) as Duplicate_Count
--	FROM [SQL_PROJECT_DATA CLEANING].[dbo].[NashvilleHousing]

--Group by PropertyAddress,SaleDateConverted,OwnerAddress,SalePrice,LegalReference

--HAVING COUNT(*) > 1 

--SELECT*
--	FROM  #TEMP_Duplicate
