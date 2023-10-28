CREATE TABLE if not exists matches(
    id INT,
    season INT,
    city VARCHAR(255),
    date DATE,
    team1 VARCHAR(255),
    team2 VARCHAR(255),
    toss_winner VARCHAR(255),
    toss_decision VARCHAR(255),
    result VARCHAR(255),
    dl_applied INT,
    winner VARCHAR(255),
    win_by_runs INT,
    win_by_wickets INT,
    player_of_match VARCHAR(255),
    venue VARCHAR(255),
    umpire1 VARCHAR(255),
    umpire2 VARCHAR(255),
    umpire3 VARCHAR(255)
);

CREATE TABLE if not exists deliveries (
    match_id INT,
    inning INT,
    batting_team VARCHAR(255),
    bowling_team VARCHAR(255),
    over INT,
    ball INT,
    batsman VARCHAR(255),
    non_striker VARCHAR(255),
    bowler VARCHAR(255),
    is_super_over INT,
    wide_runs INT,
    bye_runs INT,
    legbye_runs INT,
    noball_runs INT,
    penalty_runs INT,
    batsman_runs INT,
    extra_runs INT,
    total_runs INT,
    player_dismissed VARCHAR(255),
    dismissal_kind VARCHAR(255),
    fielder VARCHAR(255)
);


COPY "deliveries" from '/Users/kevinjxhn/Downloads/archive/deliveries.csv' delimiter ',' CSV HEADER;
COPY "matches" from '/Users/kevinjxhn/Downloads/archive/matches.csv' delimiter ',' CSV HEADER;