-- We want to reward our users who have been around the longest.
--  Find the 5 oldest users.
-- SELECT * FROM users 
-- ORDER BY created_at ASC LIMIT 5;

-- What day of the week do most users register on?
-- We need to figure out when to schedule an ad campaign
-- SELECT 	
--     DAYNAME(created_at) AS reg_day,
--     COUNT(*) AS registrations
-- FROM users
-- GROUP BY reg_day
-- ORDER BY registrations DESC LIMIT 1;

-- We want to target our inactive users with an email campaign
-- Find the users who have never posted a photo
-- SELECT username FROM users
-- LEFT JOIN photos
-- ON users.id = photos.user_id
-- WHERE ISNULL(photos.id);

-- We're running a new contest to see who can get the most likes on a single photo.
-- SELECT 
-- 	username,
--     photos.id AS photo_id,
--     COUNT(*) AS like_count 
-- FROM photos
-- INNER JOIN likes
-- 	ON likes.photo_id = photos.id
-- INNER JOIN users
-- 	ON photos.user_id = users.id
-- GROUP BY photos.id
-- ORDER BY like_count DESC LIMIT 1;


-- How many times does the average user post?

-- SELECT 	
--    (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS avg_posts;

-- A brand wants to know which hashtags to use in a post
-- What are the top 5 most commonly used hashtags?

-- SELECT tags.tag_name,COUNT(*) AS tag_count FROM tags
-- LEFT JOIN photo_tags
-- 	ON photo_tags.tag_id = tags.id
-- GROUP BY tags.id
-- ORDER BY tag_count DESC LIMIT 5;

-- We have a small problem with bots on our site. Find users who have liked
-- every single photo on the site
SELECT 	
	username,    
    COUNT(*) AS like_count    
FROM users
INNER JOIN likes
	ON users.id = likes.user_id
GROUP BY users.id
HAVING like_count = (SELECT COUNT(*) FROM photos);
