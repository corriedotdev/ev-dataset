## Scotland EV Charger Dataset 
Repo contains 4 sections
1. /ChargeScotland C# Project that will parse the JSON into a SQL DB
2. /Dataset JSON from various EV charge websites at 2 hour and 15 minute intervals for two seperate weeks. There is also an ongoing scrape folder that will continue to scrape at 15 minute intervals until something changes. In addition to SQL Database Scripts. This includes the create table and some basic queries. A .bak of the database can be found here as well if you want to get involved quickly.
3. /Scraper .ps1 (powershell) script that will scrape from chargeplace scotland. This is then attached to a task scheduler on any windows machine at the specified interval. 


### Location of Scrape
**Initially**;
Chargeplacescotland.org, Tesla.com. WIll expand.

### What Data?
You can get what chargers are available, unavailable or UNKNOWN by longitude and latitude location. Chargers include CSS, CHAdeMO and Type 2. Lat and long positions are indexed with an ID across all 4 tables. Minimal normalization has been completed to support in changes to the JSON and to help understand the data so its almost a 1:1 from JSON to SQL. Free to normalize yourself..
### Purpose?
To understand ongoing trends in the use of EV chargers in scotland and see how city planning could be improved to integrate more as part of the [2030 EV commitment.](https://www.greencarguide.co.uk/features/scotland-and-electric-vehicles-whats-happening/#:~:text=The%20Scottish%20government%20has%20now,public%20electric%20vehicle%20charging%20network.) 
As part of my PhD I am visualising geospatial positions with a modular 3D GUI to improve insight and engagement. I decided to be progressive in thought with using EV chargers as I drive an EV and noticed that really.. we need more and I can scrape this and create a dataset others can use for analysis or copy the framework for their own country.

### SQL DB 
```
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

```
## Datasets
- [Here](https://github.com/corriedotdev/ev-dataset/tree/main/Dataset/EV_DB%20Backups) the backup (EV_DB_using recent feature and last dynamic.bak) is associated with [this](https://github.com/corriedotdev/ev-dataset/tree/main/Dataset/Data/15_min_interval_1_week) data set which is 15 mins intervales for a 2 weeks

- The dataset [here](https://github.com/corriedotdev/ev-dataset/tree/main/Dataset/Data/15_min_ongoing) is for the entire month of July 2022 at 15 minute intervals. You will need to run the C# specifying this dir if you want to convert it to a DB 


## License 
[GPL.3.0](https://choosealicense.com/licenses/gpl-3.0/) There is no robots.txt on the chargeplace scotland website. Also ethical consideration given to make the requests small at spaced intervals. I own the scrape but as the data is public access I have formatted it for better querying.
