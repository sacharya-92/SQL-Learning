select count(distinct match_no) as total_match_won_by_ps from penalty_shootout;
select count(match_no) as as total_match_won_by_ps from match_mast where decided_by = 'P';