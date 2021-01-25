select distinct pm.player_name
from player_mast pm 
join player_booked pb on pm.player_id = pb.player_id 
where pb.play_half = 1 
and exists (select 1 from player_in_out pi where pb.player_id = pi.player_id and pi.in_out = 'I' and pi.play_schedule = 'NT');