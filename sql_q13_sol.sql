select p.* 
from player_mast p 
where posi_to_play in (select position_id from playing_position where position_desc = 'Defenders') 
and exists (select 1 from goal_details g where p.player_id = g.player_id)                       -- Scored a Goal
;
