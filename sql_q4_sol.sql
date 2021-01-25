SELECT  m.play_stage, COUNT(player_id) AS total_sub
FROM match_mast m
JOIN player_in_out s ON m.match_no = s.match_no
GROUP BY play_stage
;
