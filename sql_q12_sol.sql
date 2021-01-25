select team_id, play_stage, sum(goal_score) as goal_per_team_per_position 
from match_details 
group by team_id, play_stage 
having goal_per_team_per_position > 0 
;