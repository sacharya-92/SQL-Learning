with all_goal_data as (
select 
    match_no,
    goal_score, 
    substr(goal_score,1,instr(goal_score,'-')-1) as team1_goal,
    substr(goal_score,instr(goal_score,'-')+1) as team2_goal
from match_mast 
where results = 'WIN' 
and decided_by <> 'P'
-- and match_no in (41,25)
)
select match_no 
from all_goal_data t1 
where abs(team1_goal-team2_goal) = 1;