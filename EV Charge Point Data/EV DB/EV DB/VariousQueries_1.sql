
/*Select plug types at location*/
SELECT F.LONGITUDE, F.LATITUDE, F.ID
FROM DBO.Feature F
LEFT JOIN dbo.FeatureConnectorGroups G ON f.id = g.id
WHERE G.PLUGTYPENAME = 'CCS'

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
