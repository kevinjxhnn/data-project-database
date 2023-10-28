-- 1. Number of matches played per year for all the years in IPL.
SELECT season, COUNT(*) AS match_count
FROM matches
GROUP BY season;


-- 2. Number of matches won per team per year in IPL.
SELECT season, winner, count(*) as count 
FROM matches 
GROUP BY winner, season 
ORDER BY season;


-- 3. Extra runs conceded per team in the year 2016
SELECT d.bowling_team, sum(d.extra_runs)
FROM matches AS m 
JOIN deliveries AS d 
ON m.id=d.match_id 
WHERE m.season=2016 
GROUP BY d.bowling_team;


-- 4. Top 10 economical bowlers in the year 2015
SELECT
    bowler_name AS bowler,
    ROUND((SUM(runs) / SUM(balls_faced) * 6), 2) AS economyRate
FROM (
    SELECT
        d.bowler AS bowler_name,
        SUM(d.total_runs) AS runs,
        COUNT(CASE WHEN d.wide_runs = 0 AND d.noball_runs = 0 THEN 1 END) AS balls_faced
    FROM
        deliveries AS d
    JOIN
        matches AS m ON d.match_id = m.id
    WHERE
        m.season = 2015
    GROUP BY
        d.bowler
) AS BowlerStats
GROUP BY
    bowler_name
ORDER BY
    economyRate
LIMIT 10;



-- 5. Find the number of times each team won the toss and also won the match
SELECT winner, COUNT(*) AS match_count
FROM matches
WHERE toss_winner = winner
GROUP BY winner;


-- 6. Find a player who has won the highest number of Player of the Match awards for each season
SELECT
    season,
    player_of_match AS player,
    COUNT(player_of_match) AS awards
FROM
    matches
GROUP BY
    season, player_of_match
HAVING
    COUNT(player_of_match) = (
        SELECT
            MAX(award_count)
        FROM
            (
                SELECT
                    season,
                    player_of_match,
                    COUNT(player_of_match) AS award_count
                FROM
                    matches
                GROUP BY
                    season, player_of_match
            ) AS subquery
        WHERE
            subquery.season = matches.season
    );



-- 7. Find the strike rate of a batsman for each season
SELECT
    m.season,
    ROUND((SUM(d.batsman_runs) * 100.0 / COUNT(CASE WHEN d.wide_runs = 0 AND d.noball_runs = 0 THEN 1 END)), 2) AS strike_rate
FROM
    matches AS m
JOIN
    deliveries AS d ON m.id = d.match_id
WHERE
    d.batsman = 'DA Warner'  
GROUP BY
    m.season, d.batsman
ORDER BY
    m.season;


-- 8. Find the highest number of times one player has been dismissed by another player 
SELECT
    batsman AS batsman_name,
    bowler AS bowler_name,
    COUNT(*) AS count
FROM
    deliveries
WHERE
    dismissal_kind IS NOT NULL
    AND dismissal_kind <> 'run out'
GROUP BY
    batsman_name, bowler_name
ORDER BY
    count DESC
LIMIT 1;



-- 9. Find the bowler with the best economy in super overs
SELECT
    s.bowler,
    ROUND((s.runs / s.balls * 6), 2) AS economy
FROM (
    SELECT
        d.bowler,
        SUM(d.total_runs) AS runs,
        COUNT(CASE WHEN d.wide_runs = 0 AND d.noball_runs = 0 THEN 1 END) AS balls
    FROM
        deliveries AS d
    WHERE
        d.is_super_over = '1'
    GROUP BY
        d.bowler
    HAVING
        COUNT(CASE WHEN d.wide_runs = 0 AND d.noball_runs = 0 THEN 1 END) > 0
) AS s
ORDER BY
    economy
LIMIT 1;



