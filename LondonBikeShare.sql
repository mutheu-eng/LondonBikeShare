SELECT *
FROM london_merged;

-- SEPARATE THE TIMESTAMP and UPDATING THE TABLE.
ALTER TABLE london_merged ADD COLUMN date_component DATE;
ALTER TABLE london_merged ADD COLUMN time_component TIME;

UPDATE london_merged
SET date_component = DATE(timestamp),
    time_component = TIME(timestamp);

SELECT *
FROM london_merged;

ALTER TABLE london_merged
DROP COLUMN timestamp;

-- SEASON UPDATING
SELECT season, 
    CASE season
        WHEN 0 THEN "Spring"
        WHEN 1 THEN "Summer"
        WHEN 2 THEN "Fall"
        ELSE "Winter"
    END AS Season
FROM london_merged;

UPDATE london_merged
JOIN (
  SELECT season,
    CASE season
      WHEN 0 THEN "Spring"
      WHEN 1 THEN "Summer"
      WHEN 2 THEN "Fall"
      ELSE "Winter"
    END AS new_season
  FROM london_merged
) AS Season ON london_merged.season = Season.season
SET london_merged.season = Season.season;

SELECT *
FROM london_merged;

-- LETS

SELECT COUNT(*) as Num_of_Records
FROM london_merged;

-- WHICH DATE COMPONENT HAD THE HIGHEST BIKE SHARE
SELECT SUM(cnt) AS Sum_of_Count,date_component,time_component
FROM london_merged
GROUP BY date_component,time_component
ORDER BY Sum_of_Count DESC;

-- WHAT SEASON IS THE BIKE SHARE HIGH
SELECT FORMAT(SUM(cnt),0) AS Sum_of_Count,season
FROM london_merged
GROUP BY season
ORDER BY Sum_of_Count DESC;

-- MORE BIKE SHARE WHEN HOLIDAY OR NOT?
SELECT FORMAT(SUM(cnt),0) AS Sum_of_Count,is_holiday
FROM london_merged
GROUP BY is_holiday
ORDER BY Sum_of_Count DESC;

-- MORE BIKE SHARE WHEN WEEKEND OR NOT
SELECT FORMAT(SUM(cnt),0) AS Sum_of_Count,is_weekend
FROM london_merged
GROUP BY is_weekend
ORDER BY Sum_of_Count DESC;

-- AVERAGE HUMIDITY
SELECT ROUND(AVG(hum),0) AS Avg_humidity
FROM london_merged;

-- COUNT BASED ON AVERAGE(less)
SELECT SUM(cnt) AS sum_of_count,hum
FROM london_merged
WHERE hum < 72
GROUP BY hum;

-- COUNT BASED ON AVERAGE(more)
 SELECT SUM(cnt) AS sum_of_count,hum
FROM london_merged
WHERE hum > 72
GROUP BY hum;

-- BIKE SHARE BASED ON HUMIDITY
SELECT FORMAT(SUM(cnt),0) AS Sum_of_Count,hum
FROM london_merged
GROUP BY hum
ORDER BY Sum_of_Count DESC;

SELECT SUM(cnt) as Sum_of_Count
FROM  
( 
SELECT SUM(cnt) AS sum_of_count
FROM london_merged
WHERE hum < 72
GROUP BY hum 
);









