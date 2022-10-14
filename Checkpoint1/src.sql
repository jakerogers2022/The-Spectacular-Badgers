-- Checkpoint 1: SQL Analytics
-- Jake Rogers, Kelly Jiang, Alex Reneau

-- 1. Can relationships be identified between geography, and likelihood of arrest?
SELECT CAST(arrest_true_count AS float) / (arrest_true_count+arrest_false_count) AS proportion_arrest, (arrest_true_count+arrest_false_count) AS total_warrants , arrest_f.district
FROM
(SELECT Count(arrest) AS arrest_true_count, district FROM data_searchwarrant WHERE arrest = true GROUP BY district ORDER BY district) arrest_t
INNER JOIN (SELECT Count(arrest) AS arrest_false_count, district FROM data_searchwarrant WHERE arrest = false GROUP BY district ORDER BY district) arrest_f
ON arrest_f.district = arrest_t.district
ORDER BY proportion_arrest;



--Question 2: Does racial bias play a role in the outcomes of search warrants?

SELECT a.name AS district_name, race, SUM("count") population
FROM data_racepopulation dr JOIN data_area a ON a.id =dr.area_id
WHERE area_type='police-districts'
GROUP BY race, area_id, a.name
ORDER BY district_name;

SELECT a.name AS district_name, SUM("count") population, black_pop, white_pop
FROM data_racepopulation dr
    JOIN data_area a ON a.id =dr.area_id
    JOIN (
        SELECT a2.name, SUM("count") black_pop
        FROM data_racepopulation dr2 JOIN data_area a2 ON a2.id=dr2.area_id
        WHERE area_type = 'police-districts' AND race='Black'
        GROUP BY a2.name
    ) subtable ON a.name = subtable.name
    JOIN (
        SELECT a2.name, SUM("count") white_pop
        FROM data_racepopulation dr2 JOIN data_area a2 ON a2.id=dr2.area_id
        WHERE area_type = 'police-districts' AND race='White'
        GROUP BY a2.name
    ) subtable2 ON a.name = subtable2.name
WHERE area_type='police-districts'
GROUP BY district_name, black_pop,white_pop
ORDER BY district_name;

SELECT a.name AS district_name, COUNT(DISTINCT s.id) AS search_warrant_cnt, population, white_pop, black_pop
FROM data_area a
   JOIN data_searchwarrant s ON ST_INTERSECTS(a.polygon, s.point)
   JOIN data_racepopulation dr on a.id = dr.area_id
    JOIN (
        SELECT a2.name, SUM("count") black_pop
        FROM data_racepopulation dr2 JOIN data_area a2 ON a2.id=dr2.area_id
        WHERE area_type = 'police-districts' AND race='Black'
        GROUP BY a2.name
    ) subtable ON a.name = subtable.name
    JOIN (
        SELECT a2.name, SUM("count") white_pop
        FROM data_racepopulation dr2 JOIN data_area a2 ON a2.id=dr2.area_id
        WHERE area_type = 'police-districts' AND race='White'
        GROUP BY a2.name
    ) subtable2 ON a.name = subtable2.name
   JOIN (
       SELECT a2.name, SUM("count") AS population
       FROM data_racepopulation dr2 JOIN data_area a2 ON a2.id=dr2.area_id
       WHERE area_type = 'police-districts'
       GROUP BY a2.name
   ) subtable3 ON subtable3.name = a.name
WHERE area_type='police-districts'
GROUP BY district_name, population, white_pop, black_pop
ORDER BY search_warrant_cnt DESC;

-------- 3. What is the geographic extent of search warrants executed by each police unit?
SELECT avg(x.num_districts), max(x.num_districts), min(x.num_districts)
FROM (
   SELECT Count(DISTINCT district) as num_districts, policeunit_id FROM data_searchwarrant GROUP BY policeunit_id
    ) x;


-- 4. What proportion of lawsuits list unlawful search/seizure as the primary cause?
SELECT COUNT(*)
FROM lawsuit_lawsuit;

SELECT COUNT(*), primary_cause
FROM lawsuit_lawsuit
GROUP BY primary_cause
HAVING COUNT(*) > 1;

-- 5. Of the complaints categorized as improper search, what proportion alleged search of premise without a warrant?
SELECT category, allegation_name, COUNT(DISTINCT allegation_id) cr_count
FROM data_allegationcategory c JOIN data_officerallegation d
ON c.id = d.allegation_category_id
WHERE category_code ILIKE '03_'
GROUP BY category, allegation_name;

SELECT COUNT(DISTINCT allegation_id) cr_count
FROM data_allegationcategory c JOIN data_officerallegation d
ON c.id = d.allegation_category_id
WHERE category_code ILIKE '03_';

SELECT category, allegation_name, COUNT(DISTINCT allegation_id) cr_count
FROM data_allegationcategory c JOIN data_officerallegation d
ON c.id = d.allegation_category_id
WHERE category_code ILIKE '03C'
GROUP BY category, allegation_name;

SELECT DISTINCT d.allegation_id, category_code, cr_text
FROM data_allegationcategory c
    JOIN data_officerallegation d ON c.id = d.allegation_category_id
    JOIN data_allegation da ON d.allegation_id = da.crid
WHERE category_code = '03C' AND cr_text IS NOT NULL;

SELECT DISTINCT d.allegation_id, category_code, summary
FROM data_allegationcategory c
    JOIN data_officerallegation d ON c.id = d.allegation_category_id
    JOIN data_allegation da ON d.allegation_id = da.crid
WHERE category_code = '03C' AND summary<>'';





