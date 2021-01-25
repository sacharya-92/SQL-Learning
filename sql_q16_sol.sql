select r.referee_name, v.venue_name, count(m.match_no) as no_of_matches 
  from match_mast m
  join referee_mast r on r.referee_id = m.referee_id
  join soccer_venue v on m.venue_id = v.venue_id
  group by r.referee_name, v.venue_name
  ;