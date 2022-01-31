

drop table feature;
drop table featureconnectorGroups;


CREATE TABLE Feature (
	ID INT ,
    NAME VARCHAR(255),
    SITEID INT ,
    LONGITUDE Decimal(9,6) ,
    LATITUDE Decimal(8,6) ,
    PRIMARY KEY (ID)
);

CREATE TABLE FeatureConnectorGroups (
    ID INT ,
    CONNECTORID INT ,
    PLUGTYPENAME VARCHAR(255) ,
    PRIMARY KEY (ID,CONNECTORID,PLUGTYPENAME)
);


drop table dbo.Dynamic;
drop table dbo.DynamicConnectorGroups;

CREATE TABLE Dynamic (
    ID INT ,
	NAME VARCHAR(255),
    SITEID INT ,
    PRIMARY KEY (ID)
);

CREATE TABLE DynamicConnectorGroups (
    ID INT,
    CONNECTORID INT ,
    STATUS VARCHAR(255),
    TIME DATETIME,
    PRIMARY KEY (ID,CONNECTORID)
);
