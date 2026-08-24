--Creating the fact table for emissions. 
CREATE TABLE fact_esg_emissions (
    emissions_key TEXT PRIMARY KEY,
    activity_date TEXT,
    business_unit TEXT,
    facility_or_farm_id TEXT,
    region TEXT,
    ghg_scope INTEGER,
    activity_metric_value REAL,
    calculated_mt_co2e REAL
);