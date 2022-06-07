--/*Count rows*/
--SELECT count(*)
--from dbo.Dynamic

--SELECT count(*)
--from dbo.DynamicConnectorGroups

--SELECT count(*)
--from dbo.Feature

--SELECT count(*)
--from dbo.FeatureConnectorGroups

--/*Total plug types*/
--SELECT PLUGTYPENAME, count(PLUGTYPENAME) 
--FROM FeatureConnectorGroups
--GROUP by PLUGTYPENAME


--/*how many in use at time*/
--SELECT dc.id, dc.status, dc.time, fc.PLUGTYPENAME
--FROM DynamicConnectorGroups dc, FeatureConnectorGroups fc
--where dc.id = fc.id AND dc.status = 'unavailable'

--/*Select a charger status from all time data*/
--SELECT dc.id, dc.status, dc.time, fc.PLUGTYPENAME
--FROM DynamicConnectorGroups dc, FeatureConnectorGroups fc
--where dc.id = fc.id AND fc.PLUGTYPENAME = 'CCS'


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
WHERE dc.TIME ='2022-01-31 21:25:00.000'

/* Return all charger information on a specified date where status is available*/
SELECT distinct dc.STATUS,dc.CONNECTORID, dc.TIME, f.LONGITUDE,f.LATITUDE,fg.PLUGTYPENAME
FROM DynamicConnectorGroups dc
left JOIN Dynamic d ON dc.ID = d.ID 
left JOIN Feature f ON d.ID = f.ID 
left JOIN FeatureConnectorGroups fg ON f.ID = fg.ID 
WHERE dc.CONNECTORID = fg.CONNECTORID AND
fg.PLUGTYPENAME='CCS' AND   /*Type 2, CCS, CHAdeMO*/
 dc.TIME ='2022-04-14 10:00:00.000' AND
 dc.STATUS = 'AVAILABLE' /*UNAVAILABLE*/ 
 order by dc.id
 


/*Rob query*/
;with cte_DynamicConnectorGroups
as (
Select dc.id
, dc.STATUS
, dc.CONNECTORID
, dc.TIME
from DynamicConnectorGroups dc
where TIME = '2022-04-14 10:00:00.000' AND
 dc.STATUS = 'AVAILABLE'
), 

CTE_Feature AS ( select * from (
						select f.id,
						f.longitude,
						f.latitude
						,row_number() over(partition by longitude,latitude order by id) as rn
						from feature F
						where exists (select '' from dynamic as d where d.id = f.id)
				) as FDistinct 
					where rn = 1 
)
SELECT  '''' + convert(nvarchar(30) , dc.id) +''',',d.SITEID, dc.STATUS,dc.CONNECTORID, dc.TIME, f.LONGITUDE,f.LATITUDE,fg.PLUGTYPENAME
FROM cte_DynamicConnectorGroups dc
	INNER JOIN Dynamic d ON dc.ID = d.ID 
	INNER JOIN cte_feature f ON d.ID = f.ID 
	INNER JOIN FeatureConnectorGroups fg ON f.ID = fg.ID and fg.CONNECTORID  = dc.CONNECTORID 
WHERE fg.PLUGTYPENAME='CCS'
order by f.longitude 

