

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
	FCG_ID INT NOT NULL IDENTITY(1,1),
    ID INT ,
    CONNECTORID INT ,
    PLUGTYPENAME VARCHAR(255) ,
    PRIMARY KEY (FCG_ID),
	FOREIGN KEY (ID) REFERENCES Feature(ID)
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
	DCG_ID INT NOT NULL IDENTITY(1,1),
    ID INT,
    CONNECTORID INT ,
    STATUS VARCHAR(255),
    TIME DATETIME,
    PRIMARY KEY (DCG_ID),
	FOREIGN KEY (ID) REFERENCES Dynamic(ID)

);
