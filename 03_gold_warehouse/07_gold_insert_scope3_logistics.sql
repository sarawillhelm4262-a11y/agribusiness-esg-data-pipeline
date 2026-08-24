--This is inserting our scope 3 data into the fact table. I used a CTE to simplify the ton-miles calculation
--to use in the final calculation of calculated_mt_co2e
INSERT INTO fact_esg_emissions

WITH return_activity_metric_value as
(	SELECT shipment_id, 
			CASE WHEN weight_uom = 'lbs' THEN (cargo_weight / 2000.0)*distance_miles
					     WHEN weight_uom = 'MT' THEN (cargo_weight  * 1.10231) * distance_miles
					     WHEN weight_uom = 'kg' THEN (cargo_weight  / 907.184)*distance_miles
			END as activity_metric_value
	FROM logistics_shipping_raw)

SELECT g.shipment_id,
				 g.shipment_date,
				 'Supply Chain',
				 g.origin_facility,
				 'Global',
				 3,
				 r.activity_metric_value,
				 CASE WHEN g.transport_mode = 'Heavy Duty Truck' THEN  r.activity_metric_value*0.00015
				             WHEN g.transport_mode = 'Rail' THEN  r.activity_metric_value*0.00002
				 END AS calculated_mt_co2e
FROM logistics_shipping_raw g 
		     INNER JOIN return_activity_metric_value r 
			 ON g.shipment_id = r.shipment_id