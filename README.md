# 🎧 Advanced SQL Analytics & Optimization on Spotify Streaming Dataset 

<p align="center">
  <img src="assets/spotify-bg.jpg" alt="Spotify Banner" width="100%">
</p>

This project demonstrates the use of **Advanced SQL**, **query performance tuning**, and **EDA** techniques on a real-world Spotify streaming dataset. The goal was to analyze music track metrics and optimize SQL queries to deliver faster and more efficient insights.

---

## 🚀 Project Highlights

- 📁 **Dataset**: 20,000+ records of Spotify track metadata including views, likes, energy, liveness, and more
- 🛠 **Tools**: PostgreSQL, SQL Window Functions, Pandas, Python, Jupyter Notebook
- 📊 **Focus Areas**:
  - Advanced SQL analytics (window functions, ratios, aggregations)
  - Query optimization using CTEs, TEMP tables, and indexes
  - Exploratory Data Analysis (EDA)
  - Dashboard preparation and GitHub publication

---

## 📌 SQL Use Cases by Complexity

All queries are organized by difficulty and stored in [`sql/`](./sql):

### 🟢 Easy-Level Use Cases ([`easy_queries.sql`](./sql/easy_queries.sql))
- Retrieve tracks with over 1 billion streams  
- List all albums with their respective artists  
- Count comments for tracks where `licensed = TRUE`  
- Find tracks from albums labeled as `single`  
- Count total tracks grouped by artist  

### 🟡 Medium-Level Use Cases ([`medium_queries.sql`](./sql/medium_queries.sql))
- Average danceability per album  
- Top 5 tracks by highest energy  
- Tracks with views and likes where `official_video = TRUE`  
- Total views per album  
- Tracks streamed more on Spotify than YouTube  

### 🔴 Hard-Level Use Cases ([`hard_queries.sql`](./sql/hard_queries.sql))
- Top 3 most-viewed tracks per artist (window function)  
- Tracks with above-average liveness score  
- Energy range per album using a `WITH` clause  
- Tracks with energy-to-liveness ratio > 1.2  
- Cumulative likes ordered by views (window function)  

---

## ⚙️ Query Optimization Showcase

### ❓ Use Case:
**"Find artists with the highest average likes per million views"**

- ✅ Converted costly calculations inside `AVG()` into a derived column
- ✅ Replaced CTE with a `TEMP TABLE` to materialize filtered results
- ✅ Used `NULLIF` to prevent division-by-zero errors

```sql
-- Optimized version using TEMP TABLE
CREATE TEMP TABLE filtered_tracks AS
SELECT 
    artist,
    num_likes,
    num_views,
    (num_likes / NULLIF(num_views, 0)) * 1000000.0 AS likes_per_million
FROM spotify
WHERE official_video = 'TRUE' AND licensed = 'TRUE';

SELECT 
    artist,
    AVG(likes_per_million) AS avg_likes_per_million_views
FROM filtered_tracks
GROUP BY artist
ORDER BY avg_likes_per_million_views DESC
LIMIT 10;
``` 

--- 

## Optimization Results 

| Metric | Unoptimized Query | Optimized Query | 
| :---: | :---: | :---: | 
| Planning Time | 0.101 ms | 0.167 ms | 
| Execution Time | 5.999 ms | 2.699 ms | 
| Performance Gain | - | **~55%** faster | 

> 📌 Note: Indexing had negligible effect due to the dataset's size (~20k rows). The real improvement came from materializing pre-filtered rows via `TEMP TABLE`. 

## Project Structure 

```bash 
spotify-sql-analytics-optimization/
│
├── data/
│   └── cleaned_dataset.csv
│
├── sql/
│   ├── easy_queries.sql
│   ├── medium_queries.sql
│   └── hard_queries.sql
│
├── notebooks/
│   └── eda_spotify.ipynb (coming soon)
│
├── screenshots/
│   ├── query_before.png
│   └── query_after.png
│
├── dashboard/
│   └── app.py (coming soon)
│
└── README.md
``` 

## 🧠 Key Takeaways
- Refactoring logic is often more effective than indexing on small datasets
- `TEMP TABLE`s offer real performance gains and readability
- Analytical questions of increasing complexity show depth of SQL skillset 

## 📈 Future Works
- Add Streamlit dashboard for real-time track filtering and statistics 
- PostgreSQL integration? 
- Explore query tuning on a scaled-up dataset (100k+ rows) 