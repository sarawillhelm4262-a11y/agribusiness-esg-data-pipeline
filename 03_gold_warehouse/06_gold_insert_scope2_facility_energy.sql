--This is inserting the scope 2 data into the fact table

INSERT INTO fact_esg_emissions
SELECT i.invoice_id as emissions_key, 
	             i.billing_period_start as activity_date,
				 'Manufacturing' as business_unit,
				 i.facility_id as facility_or_farm_id,
				 d.true_region as region,
				2 as ghg_scope,
				 i.consumption_kwh as activity_metric_value, 
				 CASE WHEN d.true_region = 'Europe' 
							  THEN round(i.consumption_kwh * 0.00023, 4)
							  ELSE round(i.consumption_kwh * 0.00039, 4)
				 END as calculated_mt_co2e
FROM facility_energy_raw i 
LEFT JOIN dim_facilities d on i.facility_id=d.facility_id
WHERE i.consumption_kwh >0