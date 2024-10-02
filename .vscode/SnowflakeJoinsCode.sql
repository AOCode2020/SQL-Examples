SELECT 
    a."Hospital_Code",
    CASE 
        -- When the Hospital_Code is 'Total'
        WHEN a."Hospital_Code" = 'Total' 
        THEN 'Total'
        -- When there is no match for the Hospital_Code, return 'Unknown'
        WHEN b."Name" IS NULL 
        THEN 'Unknown'
        ELSE b."Name"
    END AS "Organisation_Name",
    a."Measure_Type",
    a."Measure_Category",
    a."Measure",
    a."Measure_Value",
    a."Measure_Value_Str",
    a."Effective_Snapshot_Date",
    a."Report_Period_Length"
FROM
    "Nat_Diabetes"."fact_Insulin_Pump_Audit_England" a
left JOIN 
    ODS_API."dim_Organisation_SCD" b on
    
    case
     -- When the Hospital_Code ends with two zeros 
        when a."Hospital_Code" like '%00'
     -- disregard the zeros only use first 3 digits  
        then left(a."Hospital_Code",3)
        else a."Hospital_Code"
    end = b."OrgId_extension"
    
WHERE 
   -- Remove duplicates
    IFNULL(b."Is_Latest", 1) = 1

EXCEPT SELECT * FROM "SQL_Training"."SQL_Joins_Test_Answer_Pass_And_Merit" ;
    

