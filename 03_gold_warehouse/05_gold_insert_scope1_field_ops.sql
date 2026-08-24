--This is taking our scope 1 data with valid fuel values and loading them into the fact table
INSERT INTO fact_esg_emissions (
    emissions_key, 
    activity_date, 
    business_unit, 
    facility_or_farm_id, 
    region, 
    ghg_scope, 
    activity_metric_value, 
    calculated_mt_co2e
)
SELECT f.log_id AS emissions_key, 
			     f."date" as activity_date, 
				 'Field Ops' as business_unit,
				 f.farm_id as facitility_or_farm_id,
				 CASE 
					WHEN f.farm_id = 'IOWA_NORTH_02' 
						    OR f.farm_id = 'INDIANA_WEST_01' 
					        OR f.farm_id = 'ILLINOIS_EAST_11' THEN 'North America'
					WHEN f.farm_id = 'KYIV_OBL_04' THEN 'Europe'
					WHEN f.farm_id = 'MATO_GROSSO_S1' THEN 'Latin America'
					ELSE 'Unknown' 
				END AS region,
				l.ghg_protocol_scope as ghg_scope,
				f.fuel_consumed as activity_metric_value,
				ROUND(f.fuel_consumed * co2e_factor, 4) as calculated_mt_co2e
from silver_field_operations f
LEFT JOIN emission_factors_lookup l
ON f.uom = l.unit_of_measure
WHERE l.ghg_protocol_scope = 1