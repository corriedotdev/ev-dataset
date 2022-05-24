	SELECT f.ID 
	FROM DynamicConnectorGroups dc
	INNER JOIN Dynamic d ON dc.ID = d.ID 
	INNER JOIN Feature f ON d.ID = f.ID 
	INNER JOIN FeatureConnectorGroups fg ON f.ID = fg.ID 
	WHERE dc.CONNECTORID = fg.CONNECTORID AND 
	 dc.TIME ='2022-04-13 14:21:00.000' 
	 GROUP BY f.ID
	 /*2263*/

	 SELECT f.ID 
	FROM DynamicConnectorGroups dc
	INNER JOIN Dynamic d ON dc.ID = d.ID 
	INNER JOIN Feature f ON d.ID = f.ID 
	INNER JOIN FeatureConnectorGroups fg ON f.ID = fg.ID 
	WHERE dc.CONNECTORID = fg.CONNECTORID AND 
	 dc.TIME ='2022-04-20 14:00:00.000' 
	 GROUP BY f.ID
	 INTO #MyTempTable 
	 /*2270 - so 7 new chargers were added in this week*/

 SELECT f.ID 
FROM DynamicConnectorGroups dc
INNER JOIN Dynamic d ON dc.ID = d.ID 
INNER JOIN Feature f ON d.ID = f.ID 
INNER JOIN FeatureConnectorGroups fg ON f.ID = fg.ID 
WHERE dc.CONNECTORID = fg.CONNECTORID AND 
 dc.TIME ='2022-04-20 14:00:00.000' AND 
 
NOT EXISTS (SELECT f.ID 
FROM DynamicConnectorGroups dc
INNER JOIN Dynamic d ON dc.ID = d.ID 
INNER JOIN Feature f ON d.ID = f.ID 
INNER JOIN FeatureConnectorGroups fg ON f.ID = fg.ID 
WHERE dc.CONNECTORID = fg.CONNECTORID AND 
 dc.TIME ='2022-04-13 14:21:00.000 ' )

 GROUP BY f.ID
 /*2263*/

 /*select all ids in feature that doesnt have a
 dynamic connector and drop */