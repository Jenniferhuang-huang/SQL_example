-- All new tax code which we do not have a tax category assignment (excluding non-tax product exception and discontinued code)
SELECT active_code.*, pams_tax.gl_acct_number, 
pams_tax.tax_description, rate.tax_rate, rate_type.tax_rate_type
FROM DerivedTureActiveTaxCode AS active_code
LEFT JOIN PamsProductExceptionTaxCode AS exception_code
ON active_code.tax_code = exception_code.tax_code
LEFT JOIN TaxCodeDiscontinued AS discontinue
ON active_code.tax_code = discontinue.tax_code
LEFT JOIN TaxCodeCategoryMap AS category
ON active_code.tax_code = category.tax_code
INNER JOIN pams_fs_tax_code AS pams_tax
ON active_code.tax_code = pams_tax.tax_code
INNER JOIN pams_fs_tax_code_rate AS rate
ON rate.tax_code = active_code.tax_code
INNER JOIN pams_fa_tax_code_rate_type AS rate_type
ON rate_type.tax_code = active_code.tax_code
AND rate.idx = rate_type.idx
WHERE exception_code.tax_code IS NULL
AND discontinue.tax_code IS NULL
AND category.tax_code IS NULL
AND rate.idx = '1';

-- All new tax code which we do not have a tax region assignment (excluding non-tax product exception and discontinued code)
SELECT active_code.*, pams_tax.tax_description FROM DerivedTureActiveTaxCode AS active_code
LEFT JOIN PamsProductExceptionTaxCode AS exception_code
ON active_code.tax_code = exception_code.tax_code
LEFT JOIN TaxCodeDiscontinued AS discontinue
ON active_code.tax_code = discontinue.tax_code
LEFT JOIN TaxCodeRegion AS region
ON active_code.tax_code = region.TaxCode
INNER JOIN pams_fs_tax_code AS pams_tax
ON active_code.tax_code = pams_tax.tax_code
WHERE exception_code.tax_code IS NULL
AND region.TaxCode IS NULL
AND discontinue.tax_code IS NULL

