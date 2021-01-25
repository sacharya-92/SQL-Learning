select p.jersey_no, player_name
from player_mast p 
join soccer_country s on p.team_id = s.country_id and s.country_abbr = 'GER' 
and p.posi_to_play = (select position_id from playing_position where position_desc = 'Goalkeepers')  -- Goal Keeper
and p.team_id in (select team_id from match_details where play_stage = 'G') -- Stage Matches
;