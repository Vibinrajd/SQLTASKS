-- 1.Find the number of matches played in each venue?
select
v.name Venue_Name,
count(m.id) No_of_Matches
from ipl.ipl_matches m
join ipl.venues v
on m.venue_id = v.id
group by 1
order by 2 desc;

-- 2.Find count of matches won by each team for each season?
select
t.name Team_Name,
s.name Season_Name,
count(m.id) Matches_won
from ipl.seasons s
join ipl.ipl_matches m
on s.id = m.season_id
join ipl.teams t
on m.winner_id = t.id
group by 1,2
order by 2,1;

-- 3.Season wise find the number of mom award won by player 
	-- sort by season ascending and number of mom won descending
select
s.name Season_Name,
p.Player_Name,
count(m.id) MoM_Won 
from ipl.players p
join ipl.ipl_matches m
on p.id = m.player_of_match_id
join ipl.seasons s
on m.season_id = s.id
group by 1,2
order by 1 asc, 3 desc;

-- 4.Find which player has won most number of man of the match in each season
with mom as (
select
s.name Season_Name,
p.Player_Name,
count(m.id) mom_won,
rank() over(partition by s.name order by count(m.id)desc) most_mom_winner
from ipl.seasons s
join ipl.ipl_matches m
on s.id = m.season_id
join ipl.players p
on m.player_of_match_id = p.id
group by 1,2
order by 1 asc,3 desc)
select season_name, player_name, mom_won from mom 
where most_mom_winner=1;

-- 5.Display matches participated by Umpires
select UmpireName,count(distinct id) as matches_count from (
select u.name UmpireName,m.id
from ipl.ipl_matches m
join ipl.umpires u
on m.umpire1_id = u.id
union
select u.name,m.id
from ipl.ipl_matches m
join ipl.umpires u
on m.umpire2_id = u.id) MatchbyUmpire
group by 1
order by 2 desc;