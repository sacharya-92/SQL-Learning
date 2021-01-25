-- 1. Write a SQL query to find the date EURO Cup 2016 started on.
select play_date as start_date from match_mast order by match_no limit 1;
select min(play_date) as start_date from match_mast;

-- 2. Write a SQL query to find the number of matches that were won by penalty shootout.
select count(distinct match_no) as total_match_won_by_ps from penalty_shootout;
select count(match_no) as as total_match_won_by_ps from match_mast where decided_by = 'P';

-- 3. Write a SQL query to find the match number, date, and score for matches in which no stoppage time was added in the 1st half.
select t1.match_no, t1.play_date, t1.goal_score from match_mast t1 where stop1_sec = 0;

-- 4. Write a SQL query to compute a list showing the number of substitutions that happened in various stages of play for the entire tournament.
SELECT  m.play_stage, COUNT(player_id) AS total_sub
FROM match_mast m
JOIN player_in_out s ON m.match_no = s.match_no
GROUP BY play_stage
;

-- 5. Write a SQL query to find the number of bookings that happened in stoppage time.
select count(player_id) as no_of_booking from player_booked where play_schedule = 'ST';

-- 6. Write a SQL query to find the number of matches that were won by a single point, but do not include matches decided by penalty shootout.
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

-- 7. Write a SQL query to find all the venues where matches with penalty shootouts were played.
select t1.match_no, venue_name from match_mast t1 join soccer_venue t2 on t1.venue_id = t2.venue_id and t1.decided_by = 'P';

-- 8. Write a SQL query to find the match number for the game with the highest number of penalty shots, and which countries played that match.
select m.match_no, c.country_name
from match_details m
join soccer_country c on m.team_id = c.country_id
where match_no = (select match_no 
					from (select match_no, max(kick_no) as maxkick_no 
							from penalty_shootout 
                            group by match_no order by 2 limit 1) t1);

-- 9. Write a SQL query to find the goalkeeper’s name and jersey number, playing for Germany, who played in Germany’s group stage matches. CHECK AGAIN
select p.jersey_no, player_name
from player_mast p 
join soccer_country s on p.team_id = s.country_id and s.country_abbr = 'GER' 
and p.posi_to_play = (select position_id from playing_position where position_desc = 'Goalkeepers')  -- Goal Keeper
and p.team_id in (select team_id from match_details where play_stage = 'G') -- Stage Matches
;


-- 10. Write a SQL query to find all available information about the players under contract to Liverpool F.C. playing for England in EURO Cup 2016.
select t1.* 
from player_mast t1 
join soccer_country t2 on t1.team_id = t2.country_id and t2.country_abbr = 'ENG' and t1.playing_club = 'Liverpool' 
;

-- 11. Write a SQL query to find the players, their jersey number, and playing club who were the goalkeepers for England in EURO Cup 2016.
select p.jersey_no, player_name, p.playing_club
from player_mast p 
join soccer_country s on p.team_id = s.country_id and s.country_abbr = 'ENG' 
and p.posi_to_play = (select position_id from playing_position where position_desc = 'Goalkeepers')  -- Goal Keeper
;

-- 12. Write a SQL query that returns the total number of goals scored by each position on each country’s team. Do not include positions which scored no goals.
select team_id, play_stage, sum(goal_score) as goal_per_team_per_position 
from match_details 
group by team_id, play_stage 
having goal_per_team_per_position > 0 
;

-- 13. Write a SQL query to find all the defenders who scored a goal for their teams.
select p.* 
from player_mast p 
where posi_to_play in (select position_id from playing_position where position_desc = 'Defenders') 
and exists (select 1 from goal_details g where p.player_id = g.player_id)                       -- Scored a Goal
;

-- 14. Write a SQL query to find referees and the number of bookings they made for the entire tournament. Sort your answer by the number of bookings in descending order.
select r.referee_name, count(p.player_id) as booking_per_referee 
from match_mast m 
join referee_mast r on m.referee_id = r.referee_id
join player_booked p on m.match_no = p.match_no 
group by r.referee_name 
order by 2 desc
;

-- 15. Write a SQL query to find the referees who booked the most number of players.
select r.referee_name, count(p.player_id) as booking_per_referee 
from match_mast m 
join referee_mast r on m.referee_id = r.referee_id
join player_booked p on m.match_no = p.match_no 
group by r.referee_name 
order by 2 desc
limit 1;

-- 16. Write a SQL query to find referees and the number of matches they worked in each venue.
select r.referee_name, v.venue_name, count(m.match_no) as no_of_matches 
  from match_mast m
  join referee_mast r on r.referee_id = m.referee_id
  join soccer_venue v on m.venue_id = v.venue_id
  group by r.referee_name, v.venue_name
  ;

-- 17. Write a SQL query to find the country where the most assistant referees come from, and the count of the assistant referees.
select t2.country_name, t1.ref_count 
from  (select country_id, count(ass_ref_id) as ref_count 
        from asst_referee_mast group by country_id order by 2 desc limit 1) t1 
join soccer_country t2 on t1.country_id = t2.country_id
;

-- 18. Write a SQL query to find the highest number of foul cards given in one match.
-- Did not find answer

-- 19. Write a SQL query to find the number of captains who were also goalkeepers.
select count(p.player_id) as no_of_captain_gk 
from player_mast p 
where exists (select 1 from match_captain m where p.player_id = m.player_captain and p.team_id = m.team_id)
 and p.posi_to_play = (select position_id from playing_position where position_desc = 'Goalkeepers');


-- 20. Write a SQL query to find the substitute players who came into the field in the first half of play, within a normal play schedule.
select distinct pm.player_name
from player_mast pm 
join player_booked pb on pm.player_id = pb.player_id 
where pb.play_half = 1 
and exists (select 1 from player_in_out pi where pb.player_id = pi.player_id and pi.in_out = 'I' and pi.play_schedule = 'NT');


