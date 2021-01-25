select count(p.player_id) as no_of_captain_gk 
from player_mast p 
where exists (select 1 from match_captain m where p.player_id = m.player_captain and p.team_id = m.team_id)
 and p.posi_to_play = (select position_id from playing_position where position_desc = 'Goalkeepers');