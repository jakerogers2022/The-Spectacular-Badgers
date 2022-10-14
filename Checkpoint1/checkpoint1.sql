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