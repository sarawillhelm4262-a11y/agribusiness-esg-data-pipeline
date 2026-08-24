--This creates a view for the data with valid fuel consumption metrics. These are the records we are keeping
--for our reports, while the faulty data is being loaded into a quarantine_field_operations view.

CREATE VIEW silver_field_operations AS
SELECT log_id, "date", upper(farm_id) as "farm_id", fuel_consumed, uom
FROM field_operations_raw
WHERE fuel_consumed >0 AND fuel_consumed is NOT NULL;

--This view catches missing or negative fuel data so that we can pinpoint the problem on these records
--without muddying our data or dashboard views.

CREATE VIEW quarantine_field_operations AS 
	SELECT log_id, 
					 "date", 
					 upper(farm_id), 
					 crop_type, 
					 equipment_type, 
					 fuel_type, 
					 fuel_consumed, 
					 uom, 
					CASE WHEN fuel_consumed is NULL THEN 'Missing Fuel Data'
								WHEN fuel_consumed < 0 THEN 'Negative Fuel Data'
								WHEN fuel_consumed = 0 THEN 'Fuel Data = 0'
								ELSE 'Unknown'
					END AS "Reason Failed"
	FROM field_operations_raw 
	WHERE fuel_consumed is NULL 
		             or fuel_consumed <= 0;