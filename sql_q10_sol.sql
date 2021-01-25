select t1.* 
from player_mast t1 
join soccer_country t2 on t1.team_id = t2.country_id and t2.country_abbr = 'ENG' and t1.playing_club = 'Liverpool' 
;