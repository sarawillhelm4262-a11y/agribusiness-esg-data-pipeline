--This is creating and populating the dim_facilities table
CREATE TABLE dim_facilities (
    facility_id TEXT PRIMARY KEY,
    true_region TEXT
);
INSERT INTO dim_facilities
SELECT distinct facility_id, region
FROM facility_energy_raw
WHERE region is not NULL