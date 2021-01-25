select play_date as start_date from match_mast order by match_no limit 1;
select min(play_date) as start_date from match_mast;