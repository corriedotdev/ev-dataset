Create Table dbo.Chargers(
ID uniqueidentifier PRIMARY KEY DEFAULT newid()
Name varchar(40) is null,
SiteId int is null,
Longitude Decimal(9,80),
Latitude Decimal(9,80),
DateCreated datetime default getdate()
)

Create Table dbo.ConnectorGroups(
ID uniqueidentifier PRIMARY KEY DEFAULT newid()
CargerID uniqueidentifier FOREIGN KEY (dbo.Chargers)
Name varchar(40) is null,
SiteId int is null,
Status FOREIGN KEY (Meta.ConnectorStatus)
DateCreated datetime default getdate()
DateModified datetime default getadte()
)

Create Table Meta.ConnectorStatus(
ID uniqueidentifier PRIMARY KEY DEFAULT newid(),
Name varchar(50)
)


OR-------------------------------------------------------------------------------

Create Table dbo.Chargers(
ID uniqueidentifier PRIMARY KEY DEFAULT newid()
Name varchar(40) is null,
SiteId int is null,
Longitude Decimal(9,80),
Latitude Decimal(9,80),
DateCreated datetime default getdate()
)

Create Table dbo.ConnectorGroups(
ID uniqueidentifier PRIMARY KEY DEFAULT newid()
CargerID uniqueidentifier FOREIGN KEY (dbo.Chargers)
Name varchar(40) is null,
SiteId int is null,
DateCreated datetime default getdate()
)

Create Table dbo.ConnectorGroupsStatus(
ID uniqueidentifier PRIMARY KEY DEFAULT newid(),
ConnectorID uniqueidentifier FOREIGN KEY (dbo.ConnectorGroups),
StatusID  uniqueidentifier FOREIGN KEY (Meta.ConnectorStatus),
DateCreated datetime default getdate()
)
Create Table Meta.ConnectorStatus(
ID uniqueidentifier PRIMARY KEY DEFAULT newid(),
Name varchar(50)
)