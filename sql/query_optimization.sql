-- UNOPTIMIZED VERSION
-- Goal: Find top 10 artists with highest avg likes per million views
-- Filters only for official, licensed videos and aggregates per artist
-- Added NULLIF to prevent division by zero when num_views = 0

EXPLAIN ANALYZE -- PT: 0.101 ms ET: 6.079 ms
SELECT 
    artist,
    AVG(num_likes / NULLIF(num_views, 0) * 1000000.0) AS avg_likes_per_million_views
FROM 
    spotify
WHERE 
    official_video = 'TRUE' 
    AND licensed = 'TRUE'
GROUP BY 
    artist
ORDER BY 
    avg_likes_per_million_views DESC
LIMIT 10;

-- Materialize filtered results
CREATE TEMP TABLE filtered_tracks AS
SELECT 
    artist,
    num_likes,
    num_views,
    (num_likes / NULLIF(num_views, 0)) * 1000000.0 AS likes_per_million
FROM 
    spotify
WHERE 
    official_video = 'TRUE'
    AND licensed = 'TRUE';

-- Now aggregate from the materialized result
-- EXPLAIN ANALYZE -- PT: 0.167 ms ET: 2.699 ms
SELECT 
    artist,
    AVG(likes_per_million) AS avg_likes_per_million_views
FROM 
    filtered_tracks
GROUP BY 
    artist
ORDER BY 
    avg_likes_per_million_views DESC
LIMIT 10;
