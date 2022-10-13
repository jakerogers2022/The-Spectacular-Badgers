-- Checkpoint 1: SQL Analytics
-- Jake Rogers, Kelly Jiang, Alex Reneau

-- 1. Can relationships be identified between geography, and likelihood of arrest?
SELECT CAST(arrest_true_count AS float) / (arrest_true_count+arrest_false_count) AS proportion_arrest, (arrest_true_count+arrest_false_count) AS total_warrants , arrest_f.district
FROM
(SELECT Count(arrest) AS arrest_true_count, district FROM data_searchwarrant WHERE arrest = true GROUP BY district ORDER BY district) arrest_t
INNER JOIN (SELECT Count(arrest) AS arrest_false_count, district FROM data_searchwarrant WHERE arrest = false GROUP BY district ORDER BY district) arrest_f
ON arrest_f.district = arrest_t.district
ORDER BY proportion_arrest;


-- 2. How many search warrants are executed per police unit normalized by unit size?
-------- 2a
SELECT policeunit_id, CAST(Count(*) AS float) / officer_count as num_warrants
FROM data_searchwarrant
INNER JOIN (SELECT Count(first_name) as officer_count, last_unit_id FROM data_officer group by last_unit_id) as a ON a.last_unit_id = data_searchwarrant.policeunit_id
GROUP BY policeunit_id, a.officer_count
ORDER BY num_warrants;

-------- 2b
SELECT avg(x.num_districts), max(x.num_districts), min(x.num_districts)
FROM (
   SELECT Count(DISTINCT district) as num_districts, policeunit_id FROM data_searchwarrant GROUP BY policeunit_id
    ) x;


-- 3. What proportion of lawsuits list unlawful search/seizure as the primary cause?
SELECT COUNT(*)
FROM lawsuit_lawsuit;

SELECT COUNT(*), primary_cause
FROM lawsuit_lawsuit
GROUP BY primary_cause
HAVING COUNT(*) > 1;

-- 4. What fraction of TRRs are located at residences?
SELECT COUNT(*) FROM trr_trr;

SELECT COUNT(*) FROM trr_trr WHERE 'Residence' = location;

-- 5. What fraction of lawsuits have a location listed?
SELECT COUNT(*) FROM lawsuit_lawsuit;

SELECT COUNT(*) FROM lawsuit_lawsuit WHERE location <> '';

SELECT COUNT(*) FROM lawsuit_lawsuit WHERE add1 <> '' AND add2 <> '';

SELECT COUNT(*) FROM lawsuit_lawsuit WHERE point IS NOT NULL;






