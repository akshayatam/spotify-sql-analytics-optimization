-- --------------------------------
-- SQL Analytical Questions: HARD 
-- -------------------------------- 

-- 1. Find the top 3 most-viewed tracks for each artist using window functions. 
WITH ranking_artist 
AS 
(SELECT
	artist, 
	track, 
	SUM(num_views) AS total_views, 
	DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(num_views) DESC) AS rank
FROM spotify
GROUP BY 1, 2 
ORDER BY 1, 3 DESC 
) 
SELECT * FROM ranking_artist 
WHERE rank <= 3; 

-- 2. Write a query to find tracks where the liveness score is above the average. 
SELECT 
	track, 
	artist, 
	liveness
FROM spotify 
WHERE liveness > (SELECT AVG(liveness) FROM spotify); 

-- 3. Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album. 
WITH cte
AS
(SELECT 
	album,
	MAX(energy) as highest_energy,
	MIN(energy) as lowest_energery
FROM spotify
GROUP BY 1
)
SELECT 
	album,
	highest_energy - lowest_energery as energy_diff
FROM cte
ORDER BY 2 DESC; 

-- 4. Find tracks where the energy-to-liveness ratio is greater than 1.2. 
SELECT 
    artist,
    track,
    energy,
    liveness,
    (energy / liveness) AS energy_to_liveness_ratio
FROM 
    spotify
WHERE 
    liveness > 0 AND (energy / liveness) > 1.2
ORDER BY 
    energy_to_liveness_ratio DESC;

-- 5. Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions. 
SELECT 
    track,
    num_views,
    num_likes, 
    SUM(num_likes) OVER (ORDER BY num_views DESC) AS cumulative_likes
FROM 
    spotify;