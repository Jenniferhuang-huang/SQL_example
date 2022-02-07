-- Find the hospital with the highest Pulmonary Embolism(PE) rate from 2021 Q1 (school project)
-- PE rate = # of patients with Acute PE Diagnosis / # of patients with Chest CT Scan

-- solution 1:
SELECT PEData.Site_ID, SiteList.Site_Name
,SUM(CASE WHEN PEData.CT = 'Y' AND PEData.PE_Diagnosis = 'Y' THEN 1 ELSE 0 END) AS PE_positive_count
,SUM(CASE WHEN PEData.CT = 'Y' THEN 1 ELSE 0 END) AS chest_CT_scan_count
,SUM(CASE WHEN PEData.CT = 'Y' AND PEData.PE_Diagnosis = 'Y' THEN 1 ELSE 0 END) / SUM(CASE WHEN PEData.CT = 'Y' THEN 1 ELSE 0 END) AS PE_rate
FROM PEData
LEFT JOIN SiteList ON PEData.Site_ID = SiteList.Site_ID
WHERE YEAR(PEData.Visit_Date) = 2021 AND MONTH(PEData.Visit_Date) <= 3 
GROUP BY PEData.Site_ID, SiteList.Site_Name
ORDER BY PE_rate DESC;

-- solution 2:
SELECT PEData.Site_ID, SiteList.Site_Name,
count(if (PEData.CT = 'Y' AND PEData.PE_Diagnosis = 'Y' ,1, NULL)) AS PE_positive_count,
count(if (PEData.CT = 'Y', 1, NULL)) AS chest_CT_scan_count,
count(if (PEData.CT = 'Y' AND PEData.PE_Diagnosis = 'Y' ,1 , NULL)) / count(if (PEData.CT = 'Y' ,1 ,null)) AS PE_rate
from PEData
LEFT JOIN SiteList ON PEData.Site_ID = SiteList.Site_ID
WHERE YEAR(PEData.Visit_Date) = 2021 AND MONTH(PEData.Visit_Date) <= 3 
GROUP BY PEData.Site_ID, SiteList.Site_Name 
ORDER BY PE_rate DESC