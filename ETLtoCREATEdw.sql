USE assignment_f1;
Drop PROCEDURE IF EXISTS ETL_F1_DataW;

DELIMITER $$

CREATE PROCEDURE ETL_F1_DataW()
BEGIN

DROP TABLE IF EXISTS dw_f1;

CREATE TABLE dw_f1 AS

		SELECT  r.statusId AS status_id,
                r.raceId AS race_id,
                r.driverId AS driver_id,
                r.laps,
                r.position,
                r.points,
                
                
                ra.year,
                ra.name AS circuit_name,
                
               CONCAT(d.forename, ', ', d.surname) AS driver_name,
                
               s.status
                
FROM results r
INNER JOIN races ra ON r.raceId = ra.raceId
INNER JOIN drivers d ON r.driverId = d.driverId
INNER JOIN status s ON r.statusId = s.statusId
WHERE ra.year > 2007 AND ra.year < 2021
;
END $$

DELIMITER ;

CALL ETL_F1_DataW()	