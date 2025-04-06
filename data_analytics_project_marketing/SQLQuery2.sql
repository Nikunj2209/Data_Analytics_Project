Select
*
from
dbo.customers

Select
*
from
dbo.geography
--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SQL statement to join dim_customers with dim_geography to enrich customer data with geographic information
Select 
 c.CustomerID,
 c.CustomerName,
 c.Email,
 c.Gender,
 c.Age,
 g.Country,
 g.City
From 
dbo.customers as C

Left Join
dbo.geography g
on
c.GeographyID = g.GeographyID

 




