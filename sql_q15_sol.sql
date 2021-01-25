select r.referee_name, count(p.player_id) as booking_per_referee 
from match_mast m 
join referee_mast r on m.referee_id = r.referee_id
join player_booked p on m.match_no = p.match_no 
group by r.referee_name 
order by 2 desc
limit 1;