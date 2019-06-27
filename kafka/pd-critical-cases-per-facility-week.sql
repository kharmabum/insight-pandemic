CREATE TABLE PD_CRITICAL_CASES_PER_FACILITY_PER_WEEK AS
  SELECT facility_name, count(*) AS num_cases
  FROM PD_RAW
  WINDOW TUMBLING (SIZE 7 DAY)
  WHERE disp = 'Died' OR los >= 5
  GROUP BY facility_name
  HAVING count(*) > 1;