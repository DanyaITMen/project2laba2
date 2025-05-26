-- Створення таблиці команд
CREATE TABLE team (
                      id SERIAL PRIMARY KEY,
                      name VARCHAR(50) NOT NULL,
                      city VARCHAR(50) NOT NULL
);

-- Створення таблиці результатів матчів
CREATE TABLE match_result (
                              id SERIAL PRIMARY KEY,

                              home_team_id INT NOT NULL,
                              away_team_id INT NOT NULL,

                              home_score INT NOT NULL,
                              away_score INT NOT NULL,

                              match_date DATE NOT NULL,
                              stadium VARCHAR(100),

                              CONSTRAINT fk_home_team FOREIGN KEY (home_team_id) REFERENCES team(id),
                              CONSTRAINT fk_away_team FOREIGN KEY (away_team_id) REFERENCES team(id)
);
