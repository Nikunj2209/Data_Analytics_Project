SELECT
* 
from 
dbo.products
-------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
-- SQL Query to categorize products based on their price
Select
   ProductID,
   ProductName,
   Price,

   Case
    when Price <50 Then 'LOW'
	when Price Between 50 and 200 Then 'Medium'
	Else 'High'
	End as PriceCategory
from 
dbo.products
