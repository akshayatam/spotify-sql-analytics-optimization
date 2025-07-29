-- --------------------------------
-- SQL Analytical Questions: EASY 
-- -------------------------------- 

-- 1. Retrieve the names of all tracks that have more than 1 billion streams. 
SELECT track FROM spotify 
WHERE stream > 1000000000; 

-- 2. List all albums along with their respective artists. 
SELECT DISTINCT(album), artist FROM spotify 
ORDER BY 1; 

-- 3. Get the total number of comments for tracks where licensed = TRUE 
SELECT SUM(num_comments) AS total_comments FROM spotify 
WHERE licensed = 'true'; 

-- 4. Find all the tracks that belong to the album type single. 
SELECT track FROM spotify 
WHERE album_type = 'single'; 

-- 5. Count the total number of tracks by each artist. 
SELECT 
	artist, 
	COUNT(*) as total_num_songs 
FROM spotify 
GROUP BY artist 
ORDER BY 2 DESC; 