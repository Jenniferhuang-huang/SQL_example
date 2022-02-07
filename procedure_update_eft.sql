-- create procedure to update eft report
delimiter //
CREATE PROCEDURE eftReport_import()
BEGIN
INSERT INTO eftreport (pams_id, bill_to, ename ,ecity ,estate, net_amount, card_type, entry_date)
SELECT TempEFTREPORT.F2, TempEFTREPORT.F2, qry_eftcustomerinfo.NAME, 
qry_eftcustomerinfo.CITY, qry_eftcustomerinfo.STATE, TempEFTREPORT.F4,
IF(TempEFTREPORT.F5="-", "Debit", "Credit") AS CorD, NOW() as DATE
FROM TempEFTREPORT
LEFT JOIN qry_eftcustomerinfo
ON TempEFTREPORT.F2 = qry_eftcustomerinfo.ACH_BILL_TO
WHERE TempEFTREPORT.F2 IS NOT NULL AND
qry_eftcustomerinfo.NAME IS NOT NULL AND
TempEFTREPORT.F4 > 0;
END//
delimiter ;
call eftReport_import();