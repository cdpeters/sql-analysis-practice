-- 309. Getting Lots of Instagram Data ---------------------------------------
USE instagram_clone;

SELECT *
  FROM users;

SELECT *
  FROM photos;
  
SELECT COUNT(*)
  FROM likes;


-- 311. Instagram Challenge #1 ---------------------------------------
-- find the 5 oldest users on the platform:

SELECT *
  FROM users
 ORDER BY created_at
 LIMIT 5;


-- 313. Instagram Challenge #2 ---------------------------------------
-- what day of the week do most users register on (we need to figure out when
-- to schedule an ad campaign)?

SELECT DAYNAME(created_at) AS day,
       COUNT(*) AS total_registered
  FROM users
 GROUP BY day
 ORDER BY total_registered DESC;

-- result shows Sunday and Thursday are the days most registered on


-- 315. Instagram Challenge #3 ---------------------------------------
-- we want to target our active users with an email campaign. Find the users
-- who have never posted a photo:

-- this query was created as a view to answer the second question in this section
CREATE VIEW inactive_users AS
SELECT users.username
  FROM users
       LEFT JOIN photos
       ON users.id = photos.user_id
 WHERE photos.image_url IS NULL;

SELECT *
  FROM inactive_users;

-- how many inactive users are there?

SELECT COUNT(*) AS inactives_count
  FROM inactive_users;

-- there are 26 inactive users


-- 317. Instagram Challenge #4 ---------------------------------------
-- We're running a new contest to see who can get the most likes on a single
-- photo. Who has the most?

SELECT users.username,
       photos.id AS photo_id,
       COUNT(*) AS like_count
  FROM users
       INNER JOIN photos
       ON users.id = photos.user_id
       INNER JOIN likes
       ON photos.id = likes.photo_id
 GROUP BY photo_id
 ORDER BY like_count DESC
 LIMIT 1;
 
 
 -- username Zack_Kemmer93 has the most liked photo at 48 likes


-- 319. Instagram Challenge #5 ---------------------------------------
-- How many times does the average user post?

-- preliminary table to see the number of uploads per user
SELECT users.username,
       COUNT(photos.image_url) AS uploads
  FROM users
       LEFT JOIN photos
       ON users.id = photos.user_id
 GROUP BY users.username;
 
-- calculating the average uploads per user
 SELECT AVG(upload_counts.uploads) AS avg_uploads
  FROM (SELECT users.username,
               COUNT(photos.image_url) AS uploads
          FROM users
               LEFT JOIN photos
               ON users.id = photos.user_id
         GROUP BY users.username) AS upload_counts;

-- the average uploads per user is 2.57

-- repeating the calculation on active users only
SELECT AVG(upload_counts.uploads) AS avg_uploads
  FROM (SELECT users.username,
               COUNT(photos.image_url) AS uploads
          FROM users
               INNER JOIN photos
               ON users.id = photos.user_id
         GROUP BY users.username) AS upload_counts;

-- the average uploads per active user is 3.47

-- another way to calculate the average number of uploads per user
SELECT (SELECT COUNT(*) FROM photos)/(SELECT COUNT(*) FROM users) AS avg_uploads;
 

-- 321. Instagram Challenge #6 ---------------------------------------
-- A brand wants to know which hashtags to use in a post. What are the top 5
-- most commonly used hashtags?

-- this query uses a simple limit. It turns out that there is a tie for the 5th
-- most commonly used hashtag between 3 hashtags (only 'concert' is shown here).
SELECT tags.tag_name,
       COUNT(*) AS count
  FROM photo_tags
       INNER JOIN tags
       ON photo_tags.tag_id = tags.id
 GROUP BY tags.tag_name
 ORDER BY count DESC
 LIMIT 5;

-- this captures the top 5 most commonly used hashtags and allows for repeats in
-- the event of a tie
  WITH tag_counts AS 
       (SELECT tags.tag_name,
               COUNT(*) AS count
          FROM photo_tags
               INNER JOIN tags
               ON photo_tags.tag_id = tags.id
         GROUP BY tags.tag_name),
       tag_ranks AS 
       (SELECT tag_counts.tag_name,
               tag_counts.count,
               RANK() OVER(ORDER BY tag_counts.count DESC) AS tag_rank
          FROM tag_counts)
SELECT *
  FROM tag_ranks
 WHERE tag_rank <= 5;

-- the 5 most commonly used hashtags are:
--     1. smile
--     2. beach
--     3. party
--     4. fun
--     5. concert
--     5. food
--     5. lol


-- 323. Instagram Challenge #7 ---------------------------------------
-- We have a small problem with bots on our site. Find users who have liked
-- every single photo on the site
SELECT users.username AS bots_list
  FROM users
       INNER JOIN likes
       ON users.id = likes.user_id
 GROUP BY users.username
HAVING COUNT(*) = (SELECT COUNT(*)
                     FROM photos);
