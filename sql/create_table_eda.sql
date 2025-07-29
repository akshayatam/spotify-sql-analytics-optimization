-- Spotify Data Analysis Project 

-- Create table 
DROP TABLE IF EXISTS spotify; 
CREATE TABLE spotify (
	artist VARCHAR(255), 
	track VARCHAR(255), 
	album VARCHAR(255), 
	album_type VARCHAR(255), 
	danceability FLOAT, 
	energy FLOAT, 
	loudness FLOAT, 
	speechiness FLOAT, 
	acousticness FLOAT, 
	instrumentalness FLOAT, 
	liveness FLOAT, 
	valence FLOAT, 
	tempo FLOAT, 
	duration_min FLOAT, 
	title VARCHAR(255), 
	channel VARCHAR(255), 
	num_views FLOAT, 
	num_likes BIGINT, 
	num_comments BIGINT, 
	licensed BOOLEAN, 
	official_video BOOLEAN, 
	stream BIGINT, 
	energy_liveness FLOAT, 
	most_played_on VARCHAR(255)
); 

-- EDA 
SELECT COUNT(*) FROM spotify; 

SELECT COUNT(DISTINCT artist) FROM spotify; 

SELECT COUNT(DISTINCT album) FROM spotify; 

SELECT DISTINCT album_type FROM spotify; 

SELECT duration_min FROM spotify; 
SELECT MAX(duration_min) FROM spotify; 
SELECT MIN(duration_min) FROM spotify; 

-- Check the song with 0 duration 
SELECT * FROM spotify 
WHERE duration_min = 0; 

-- Delete these songs 
DELETE FROM spotify 
WHERE duration_min = 0; 

SELECT * FROM spotify 
WHERE duration_min = 0; 