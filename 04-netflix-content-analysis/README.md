# Netflix — Content Performance & Strategy Analysis

## Objective
Analyze Netflix's content catalog to identify high-engagement content types, genres, and markets, and turn that into strategic investment recommendations.

## Dataset
Title-level catalog data including `type` (Movie/TV Show), `country`, `release_year`, `rating`, `genres`, `popularity`, `vote_count`, and `vote_average`.

## Key Findings

**Content type**
- TV Shows show significantly higher popularity than Movies.
- Movies edge out TV Shows slightly on average rating.
- Interpretation: shows drive engagement/retention, movies drive perceived quality.

**Genre**
- Animation, Action, and Sci-Fi dominate high-performing content.
- Interpretation: audiences favor immersive, high-engagement storytelling.

**Country**
- USA delivers both high volume and strong engagement.
- Japan delivers high efficiency — strong performance from a smaller catalog footprint.
- Interpretation: a blended strategy of scale (USA) plus niche, high-efficiency markets (Japan) makes sense.

## Limitations
- Time-based fields are uniformly distributed in this dataset, so trend-over-time analysis isn't reliable here.

## Recommendations
- Invest more in TV Shows as the primary retention engine
- Focus content investment on Action, Animation, and Sci-Fi genres
- Expand in high-performing niche markets like Japan
- Look for ways to improve engagement on movie content specifically

## Files
- `p2_ Netflix.docx` — full write-up
- `Netflix Data.pbix` — Power BI dashboard
- `Netflix India Main.csv` — underlying catalog dataset

## Tools
Power BI, Excel/CSV
