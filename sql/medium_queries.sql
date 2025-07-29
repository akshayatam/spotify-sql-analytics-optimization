-- --------------------------------
-- SQL Analytical Questions: MEDIUM 
-- -------------------------------- 

-- 1. Calculate the average danceability of tracks in each album. 
SELECT 
	album, 
	AVG(danceability) AS average_danceability 
FROM spotify 
GROUP BY album 
ORDER BY 2 DESC; 

-- 2. Find the top 5 tracks with the highest energy values. 
SELECT 
	track, 
	MAX(energy)  
FROM spotify 
GROUP BY track  
ORDER BY 2 DESC 
LIMIT 5; 

-- 3. List all tracks along with their views and likes where official_video = TRUE 
SELECT 
	track, 
	SUM(num_views) AS total_views, 
	SUM(num_likes) AS total_likes
FROM spotify 
WHERE official_video = 'true'
GROUP BY 1; 

-- 4. For each album, calculate the total views of all associated tracks. 
SELECT 
	album, 
	track, 
	SUM(num_views) AS total_views 
FROM spotify 
GROUP BY 1, 2 
ORDER BY 3 DESC; 

-- 5. Retrieve the track names that have been streamed on Spotify more than YouTube. 
SELECT * FROM(
SELECT 
	track, 
	COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END), 0) AS streamed_on_youtube, 
	COALESCE(SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END), 0) AS streamed_on_spotify
FROM spotify 
GROUP BY 1
) as t1 
WHERE 
	streamed_on_spotify > streamed_on_youtube 
	AND 
	streamed_on_youtube <> 0; 