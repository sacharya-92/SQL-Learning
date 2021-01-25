select t1.match_no, venue_name from match_mast t1 join soccer_venue t2 on t1.venue_id = t2.venue_id and t1.decided_by = 'P';
