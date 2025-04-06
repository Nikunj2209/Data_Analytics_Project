Select * from dbo.customer_reviews
-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Query to clean whitespace issues in the ReviewText column

Select
ReviewID,
CustomerID,
ProductID,
ReviewDate,
Rating,
Replace(ReviewText, '  ',' ') As ReviewText
From
dbo.customer_reviews
-------------------------------------------------------------------------------------------------------------------------------------------------------
