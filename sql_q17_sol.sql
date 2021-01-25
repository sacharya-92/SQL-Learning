select t2.country_name, t1.ref_count 
from  (select country_id, count(ass_ref_id) as ref_count 
        from asst_referee_mast group by country_id order by 2 desc limit 1) t1 
join soccer_country t2 on t1.country_id = t2.country_id
;
