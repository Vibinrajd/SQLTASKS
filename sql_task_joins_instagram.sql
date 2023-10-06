-- 1. Find the 5 oldest users of the Instagram from the database provided
select
username,
created_at
from instagram.users
order by 2
limit 5;

-- 2.Find the users who have never posted a single photo on Instagram
select
username
from instagram.users u
left join instagram.photos p
on u.id = p.user_id
where p.user_id is null;

-- 3.Identify the winner of the contest and provide their details to the team.
select
l.photo_id,
u.username,
count(l.user_id) likes
from instagram.likes l
inner join instagram.photos p
on l.photo_id = p.id
inner join instagram.users u
on p.user_id = u.id
group by 1,2
order by 3 desc
limit 1;

-- 4.Identify and suggest the top 5 most commonly used hashtags on the platform.
select
tag_name,
count(pt.photo_id)
from instagram.photo_tags pt
inner join instagram.tags t
on pt.tag_id = t.id
group by 1
order by 2 desc
limit 5;

-- 5. What day of the week do most users register on? 
	-- Provide insights on when to schedule an ad campaign
    
select
weekday(created_at) weekday,
count(username) users
from instagram.users
group by 1
order by 1;

--  6.Provide how many times does average user posts on Instagram. 
	-- Also, provide the total number of photos on Instagram/total number of users.
    
with users as (
select
u.id user_id,
count(p.id) photo_id
from instagram.users u
left join instagram.photos p
on u.id = p.user_id
group by 1)
select 
	sum(photo_id) Total_Photos,
    count(user_id) Total_Users,
    sum(photo_id)/count(user_id) Total_posts_by_User
from users;



