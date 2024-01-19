create DATABASE Station_Store;
use station_Store;

/*Q1) Create a table “STATION ” to store information about weather observation stations:

ID	Number | Primary key
CITY	     |   CHAR(20)
STATE	    |   CHAR(2)	
LAT_N    	|   Number	
LONG_W   	|  Number	

CODE:- */

CREATE TABLE STATION (
ID INTEGER PRIMARY KEY,
CITY CHAR(20),
STATE CHAR(2),
LAT_N REAL,
LONG_W REAL
);

/* Q2) Insert the following records into the table:

ID	| CITY	   |  STATE	| LAT_N	| LONG_W
13	| PHOENIX	|   AZ	  | 33	   |  112
44	| DENVER	 |   CO	  | 40	   |  105
66	| CARIBOU	|   ME	  | 47	   |  68

CODE:-*/

INSERT INTO STATION VALUES (13, 'Phoenix', 'AZ', 33, 112);
INSERT INTO STATION VALUES (44, 'Denver', 'CO', 40, 105);
INSERT INTO STATION VALUES (66, 'Caribou', 'ME', 47, 68);

/* Q3) Execute a query to look at table STATION in undeﬁned order.

CODE:- */

SELECT * FROM STATION; 


/* Q4) Execute a query to select Northern stations (Northern latitude > 39.7).

CODE:- */

SELECT * FROM STATION WHERE LAT_N >39.7;


/* Q5) Create another table, ‘STATS’, to store normalized temperature and precipitation data:
Column	Data type	Remark
ID	Number	ID must match with some ID from the STATION
table(so name & location will be known).
MONTH	Number	The range of months is between (1 and 12)
TEMP_F	Number	Temperature is in Fahrenheit degrees, Ranging between (80 and 150)
RAIN_I	Number	Rain is in inches, Ranging between (0 and 100)

There will be no Duplicate ID and MONTH combination.

CODE:- */

CREATE TABLE STATS(
ID INTEGER REFERENCES STATION(ID),
MONTH INTEGER CHECK (MONTH BETWEEN 1 AND 12),
TEMP_F REAL CHECK (TEMP_F BETWEEN -80 AND 150),
RAIN_I REAL CHECK (RAIN_I BETWEEN 0 AND 100),
PRIMARY KEY (ID, MONTH)
); 


/* Q6) Populate the table STATS with some statistics for January and July:
       ID	| MONTH	| TEMP_F	| RAIN_I
       13	|   1	  | 57.4	  |  .31
       13	|  	7	  | 91.7		 | 5.15
       44	|  	1	  | 27.3   |	 .18
       44	|  	7	  | 74.8	  | 2.11
       66	|  	1	  | 6.7	   | 2.1
       66	|  	7	  | 65.8	  | 4.52

CODE:- */

INSERT INTO STATS VALUE (13,1,57.4,.31);
INSERT INTO STATS VALUE (13,7,91.4,5.15);
INSERT INTO STATS VALUE (44,1,27.3,.18);
INSERT INTO STATS VALUE (44,7,74.8,2.11);
INSERT INTO STATS VALUE (66,1,6.7,2.1);
INSERT INTO STATS VALUE (66,7,65.8,4.52);


/*Q7) Execute a query to display temperature stats (from the STATS table) for each city (from the STATION table).

CODE:- */

SELECT * FROM STATION, STATS
WHERE STATION.ID = STATS.ID;
 

/* Q8) Execute a query to look at the table STATS, ordered by month and greatest rainfall, with columns rearranged. It should also show the corresponding cities.

CODE:- */

SELECT CITY, MONTH, STATION.ID, RAIN_I, TEMP_F
FROM STATS
RIGHT JOIN STATION ON STATS.ID = STATION.ID
ORDER BY MONTH, RAIN_I DESC;


/* Q9) Execute a query to look at temperatures for July from table STATS, lowest temperatures ﬁrst, picking up city name and latitude.

CODE:- */

SELECT TEMP_F, CITY, LAT_N
FROM STATS, Station
WHERE MONTH = 7
AND STATS.ID = Station.ID
ORDER BY TEMP_F;


/* Q10) Execute a query to show MAX and MIN temperatures as well as average rainfall for each city.

CODE:- */

SELECT ID, MAX(TEMP_F), MIN(TEMP_F), AVG(RAIN_I), ID
FROM STATS
GROUP BY ID;


/* Q11) Execute a query to display each city’s monthly temperature in Celcius and rainfall in Centimeter.

CODE:- */

SELECT ST.CITY,S.MONTH,
ROUND(((S.TEMP_F-32) * 5/9), 2) AS TEMPERATURE_CELCIUS,
ROUND((S.RAIN_I * 2.54), 2) AS RAINFALL_CENTIMETER FROM STATS S
JOIN STATION ST
ON S.ID=ST.ID;


/* Q12) Update all rows of table STATS to compensate for faulty rain gauges known to read 0.01 inches low.

CODE:-*/ 

UPDATE STATS SET RAIN_I = RAIN_I + 0.01
FROM STATS;	


/* Q13) Update Denver's July temperature reading as 74.9.

CODE:- */ 

UPDATE STATS
SET TEMP_F = 74.9
WHERE ID = 44
AND MONTH = 7;
