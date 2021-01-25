select m.match_no, c.country_name
from match_details m
join soccer_country c on m.team_id = c.country_id
where match_no = (select match_no 
					from (select match_no, max(kick_no) as maxkick_no 
							from penalty_shootout 
                            group by match_no order by 2 limit 1) t1);
