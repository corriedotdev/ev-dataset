 /*Count rows*/
SELECT count(*)
from dbo.Dynamic

SELECT count(*)
from dbo.DynamicConnectorGroups

SELECT count(*)
from dbo.Feature

SELECT count(*)
from dbo.FeatureConnectorGroups

/*Total plug types*/
SELECT PLUGTYPENAME, count(PLUGTYPENAME) 
FROM FeatureConnectorGroups
GROUP by PLUGTYPENAME


/*how many in use at time*/
SELECT dc.id, dc.status, dc.time, fc.PLUGTYPENAME
FROM DynamicConnectorGroups dc, FeatureConnectorGroups fc
where dc.id = fc.id AND dc.status = 'unavailable'

/*Select a charger status from all time data*/
SELECT dc.id, dc.status, dc.time, fc.PLUGTYPENAME
FROM DynamicConnectorGroups dc, FeatureConnectorGroups fc
where dc.id = fc.id AND fc.PLUGTYPENAME = 'CCS'


/* Select all dynamic data based on a specific time */
SELECT * 
FROM DynamicConnectorGroups dc
INNER JOIN Dynamic d
ON dc.ID = d.ID 
WHERE dc.TIME ='2022-01-31 21:25:00.000'

/* Select long lat position on day*/
SELECT * 
FROM DynamicConnectorGroups dc
INNER JOIN Dynamic d ON dc.ID = d.ID 
INNER JOIN Feature f ON d.ID = f.ID 
WHERE dc.TIME ='2022-04-13 14:21:00.000'

/* Return all charger information on a specified date where status is available*/
SELECT * 
FROM DynamicConnectorGroups dc
INNER JOIN Dynamic d ON dc.ID = d.ID 
INNER JOIN Feature f ON d.ID = f.ID 
INNER JOIN FeatureConnectorGroups fg ON f.ID = fg.ID 
WHERE dc.CONNECTORID = fg.CONNECTORID AND /* this is needed as the connectorID is the same as ID  */
 dc.TIME ='2022-04-13 22:00:00.000' AND dc.STATUS = 'AVAILABLE'

 select * from DynamicConnectorGroups WHERE  /* this is needed as the connectorID is the same as ID  */
STATUS = 'AVAILABLE'


/*Select plug types at location*/
SELECT *
FROM DBO.Feature F
LEFT JOIN dbo.FeatureConnectorGroups G ON f.id = g.id
WHERE G.PLUGTYPENAME = 'CCS'



/*Delete features that are empty using latest static json and dynamic data going back historically*/
/* feature-23-05-2022-18-41-00 - dynamic-20-04-2022-14-00-00*/
select * FROM DynamicConnectorGroups 
WHERE TIME = '2022-04-13 14:21:00.000'

/*Select all the charger ID's that were available on the first scrape*/
SELECT f.ID 
FROM DynamicConnectorGroups dc
INNER JOIN Dynamic d ON dc.ID = d.ID 
INNER JOIN Feature f ON d.ID = f.ID 
INNER JOIN FeatureConnectorGroups fg ON f.ID = fg.ID 
WHERE dc.CONNECTORID = fg.CONNECTORID AND /* this is needed as the connectorID is the same as ID  */
 dc.TIME ='2022-04-13 14:21:00.000' 

 SELECT @@version.


ID NOT IN 
       (SELECT ID 
        FROM Dynamic 
        WHERE ID is NOT NULL /*This line is unlikely to be needed 
                               but using NOT IN...*/
      )

select ID FROM DynamicConnectorGroups 
WHERE ID NOT IN 
       (SELECT ID 
        FROM Dynamic 
        WHERE ID is NOT NULL /*This line is unlikely to be needed 
                               but using NOT IN...*/
      )

	  13-04-2022