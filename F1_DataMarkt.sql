USE assignment_f1;

DROP PROCEDURE IF EXISTS F1_DataMarts;
DELIMITER $$

CREATE PROCEDURE F1_DataMarts()

BEGIN

DROP VIEW IF EXISTS Disq_view;

CREATE VIEW Disq_view AS
	SELECT  f.driver_name,
			f.circuit_name,
            f.year,
            f.status
    FROM dw_f1 f
    WHERE f.status_id <> 1 AND
			f.status not like '+%'
    GROUP BY 	f.circuit_name,
				f.driver_name,
                f.status,
				f.year;
                
--
DROP VIEW IF EXISTS driver_dvelop_view;

CREATE VIEW driver_dvelop_view AS
	SELECT f.driver_name,
			f.year,
            SUM(f.points) AS earned_points,
            AVG(f.position) AS avg_position
    FROM dw_f1 f
    GROUP BY f.year,
			f.driver_name
;

--
DROP VIEW IF EXISTS most_laps_view;

CREATE VIEW most_laps_view AS
	SELECT f.driver_name,
			SUM(f.laps) AS drived_laps
    FROM dw_f1 f
    GROUP BY f.driver_name
    ORDER BY drived_laps
    
;
END $$

DELIMITER ;

CALL F1_DataMarts();