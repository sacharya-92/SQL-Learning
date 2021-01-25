select p.jersey_no, player_name, p.playing_club
from player_mast p 
join soccer_country s on p.team_id = s.country_id and s.country_abbr = 'ENG' 
and p.posi_to_play = (select position_id from playing_position where position_desc = 'Goalkeepers')  -- Goal Keeper
;