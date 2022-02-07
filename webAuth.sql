-- Find average fuel burn rates for web authorizations that have unreasonable volumes (gallons<=10)
SELECT trim(aircraft.tail) AS tail, trim(aircraft.CUSTOM_ID) AS id, 
trim(aircraft.aircraft_type) AS aircraft_type, fuel_info.avg_fuel_burn AS burn_rate
FROM [DEV-ACIS].ACIS_CURRENT.SYSDBA.ACCT_AIRCRAFT AS aircraft
INNER JOIN WebAuth AS auth
ON auth.tail = aircraft.tail
INNER JOIN [DEV-ACIS].ACIS_CURRENT.SYSDBA.aircraft_master AS fuel_info
ON aircraft.CUSTOM_ID = fuel_info.CUSTOM_ID 
AND aircraft.aircraft_type = fuel_info.aircraft_type
WHERE aircraft.active_flag = 'T' 
AND aircraft.tail IS NOT NULL 
AND aircraft.aircraft_type IS NOT NULL
AND auth.Gallons <= 10 
AND auth.NextDestination IS NOT NULL 
AND fuel_info.active_flag = 'T' 
AND fuel_info.avg_fuel_burn IS NOT NULL
GROUP BY tail, id, aircraft_type, burn_rate;