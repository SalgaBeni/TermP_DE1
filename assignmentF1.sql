-- You can download the data from: https://www.kaggle.com/rohanrao/formula-1-world-championship-1950-2020
--
--
DROP SCHEMA IF EXISTS assignment_f1;
	CREATE SCHEMA assignment_f1;
    
USE assignment_f1;

DROP TABLE IF EXISTS races;
	CREATE TABLE races 
		(raceId INTEGER NOT NULL,
		year INTEGER,
		round INTEGER,
		circuitId INTEGER NOT NULL,
		name VARCHAR(255),
		date DATE NOT NULL,
		time TIME,
		url VARCHAR(255),
		PRIMARY KEY(raceId));

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/races.csv'
INTO TABLE races
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES terminated BY '\n'
IGNORE 1 LINES
	(raceId, year, round, circuitId, name, date, time, url);
    
ALTER TABLE races
	DROP COLUMN round,
    DROP COLUMN circuitId,
    DROP COLUMN time,
    DROP COLUMN url;
    

DROP TABLE IF EXISTS drivers;
	CREATE TABLE drivers 
		(driverId INTEGER NOT NULL,
		driverRef VARCHAR(155),
		number VARCHAR(55),
		code VARCHAR(5),
		forename VARCHAR(155),
		surname VARCHAR(155),
		dob DATE,
		nationality VARCHAR(155),
		url VARCHAR(255),
		PRIMARY KEY(driverId));

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/drivers.csv'
INTO TABLE drivers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
	(driverId, driverRef, number, code, forename, surname, dob, nationality, url);

ALTER TABLE drivers
	DROP COLUMN driverRef,
    DROP COLUMN number,
    DROP COLUMN url;


DROP TABLE IF EXISTS status;
	CREATE TABLE status
		(statusId INTEGER NOT NULL,
		status VARCHAR(85),
		PRIMARY KEY(statusId));


LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/status.csv'
INTO TABLE status
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
	(statusId, status);


DROP TABLE IF EXISTS results;
	CREATE TABLE results 
		(resultId INTEGER NOT NULL,
		raceId INTEGER NOT NULL,
		driverId INTEGER NOT NULL,
		constructorId INTEGER NOT NULL,
		number INTEGER,
		grid INTEGER,
		position INTEGER,
		positionText VARCHAR(20),
		positionOrder INTEGER,
		points INTEGER,
		laps INTEGER,
		time VARCHAR(105),
		milliseconds INTEGER,
		fastestLap INTEGER,
		ranking INTEGER,
		fastestLapTime VARCHAR(105),
		fastestLapSpeed VARCHAR(105),
		statusId INTEGER NOT NULL,
		PRIMARY KEY(resultId),
        CONSTRAINT 	resultsF1K1 FOREIGN KEY (raceId) REFERENCES races(raceId),
        CONSTRAINT 	resultsF1K2 FOREIGN KEY (driverId) REFERENCES drivers(driverId),
        CONSTRAINT 	resultsF1K3 FOREIGN KEY (statusId) REFERENCES status(statusId));

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/result2.csv'
INTO TABLE results
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
	(resultId, raceId, driverId, constructorId, number, grid, position, positionText, positionOrder, points, laps, time, milliseconds, 
	fastestLap, ranking, fastestLapTime, fastestLapSpeed, statusId);

ALTER TABLE results
	DROP COLUMN constructorId,
    DROP COLUMN positionText,
    DROP COLUMN time,
    DROP COLUMN milliseconds,
    DROP COLUMN fastestLap,
    DROP COLUMN fastestLapTime,
    DROP COLUMN fastestLapSpeed;
    
    
DROP TABLE IF EXISTS qualifying;
	CREATE TABLE qualifying 
		(qualifyId INTEGER NOT NULL,
		raceId INTEGER NOT NULL,
		driverId INTEGER NOT NULL,
		constructorId INTEGER NOT NULL,
		number INTEGER,
		position INTEGER,
		q1 TIME,
		q2 TIME,
		q3 TIME,
		PRIMARY KEY(qualifyId),
        CONSTRAINT 	resultsF1K4 FOREIGN KEY (raceId) REFERENCES races(raceId),
        CONSTRAINT 	resultsF1K5 FOREIGN KEY (driverId) REFERENCES drivers(driverId));
		

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/qualifying.csv'
INTO TABLE qualifying 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
	(qualifyId, raceId, driverId, constructorId, number, position, q1, q2, q3);

ALTER TABLE qualifying
	DROP COLUMN constructorId,
    DROP COLUMN q1,
    DROP COLUMN q2,
    DROP COLUMN q3;

DROP TABLE IF EXISTS driver_standings;
	CREATE TABLE driver_standings 
		(driverStandingsId INTEGER NOT NULL,
		raceId INTEGER NOT NULL,
		driverId INTEGER NOT NULL,
		points INTEGER,
		position INTEGER,
		positionText VARCHAR(50),
		wins INTEGER,
		PRIMARY KEY(driverStandingsId),
        CONSTRAINT 	resultsF1K6 FOREIGN KEY (driverId) REFERENCES drivers(driverId),
        CONSTRAINT 	resultsF1K7 FOREIGN KEY (raceId) REFERENCES races(raceId));

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/driver_standings.csv'
INTO TABLE driver_standings
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
	(driverStandingsId, raceId, driverId, points, position, positionText, wins);

ALTER TABLE driver_standings
	DROP COLUMN positionText;