Select 
*
from 
dbo.engagement_data
-------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Query to clean and normalize the engagement_data table

SELECT 
    EngagementID,
    ContentID,
    CampaignID,
    ProductID,
    UPPER(REPLACE(ContentType, 'SocialMedia', 'Social Media')) AS ContentType,
    -- Corrected typo in the column name (ViewsClicksCombined)
    LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined) - 1) AS Views,
    RIGHT(ViewsClicksCombined, LEN(ViewsClicksCombined) - CHARINDEX('-', ViewsClicksCombined)) AS Clicks,
    Likes,
    -- Ensuring EngagementDate is properly formatted
    FORMAT(CONVERT(DATE, EngagementDate), 'dd.MM.yyyy') AS EngagementDate
FROM
    dbo.engagement_data
WHERE 
    ContentType != 'Newsletter';

