SET SEARCH_PATH = "schema_after_dop";

CREATE TABLE "LIGHTNING_STRIKES"
(
    id          SERIAL PRIMARY KEY,
    strike_time TIME DEFAULT now() + interval '3 hours',
    strength    INTEGER CHECK ( strength between 0 AND 100 ) DEFAULT 50
);

CREATE TABLE "WEB"
(
    id    SERIAL PRIMARY KEY,
    power INTEGER CHECK ( power BETWEEN 0 AND 1000 )
);

CREATE TABLE "RAMS"
(
    id       SERIAL PRIMARY KEY,
    name     VARCHAR(15) NOT NULL,
    capacity INTEGER CHECK ( capacity > 0 )
);

CREATE TABLE "MONITORS"
(
    id     SERIAL PRIMARY KEY,
    name   VARCHAR(15) NOT NULL,
    height INTEGER CHECK ( height > 0 ),
    length INTEGER CHECK ( length > 0 )
);

CREATE TABLE "MEMORIES"
(
    id       SERIAL PRIMARY KEY,
    name     VARCHAR(15)                    NOT NULL,
    capacity INTEGER CHECK ( capacity > 0 ) NOT NULL
);

CREATE TABLE "COMPUTERS"
(
    id             SERIAL PRIMARY KEY,
    os_name        VARCHAR(15),
    ram_id         INTEGER NOT NULL,
    FOREIGN KEY (ram_id) REFERENCES "RAMS" (id),
    monitor_id     INTEGER NOT NULL,
    FOREIGN KEY (monitor_id) REFERENCES "MONITORS" (id),
    memory_id      INTEGER NOT NULL,
    FOREIGN KEY (memory_id) REFERENCES "MEMORIES" (id),
    web_id         INTEGER,
    FOREIGN KEY (web_id) REFERENCES "WEB" (id)
);

CREATE TABLE "PEOPLE"
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(15) NOT NULL,
    computer_id INTEGER,
    FOREIGN KEY (computer_id) REFERENCES "COMPUTERS" (id)
);


CREATE TABLE "COMPONENTS_HEALTH" (
    computer_id INTEGER UNIQUE,
    FOREIGN KEY (computer_id) REFERENCES "COMPUTERS" (id),
    ram_health INTEGER CHECK ( ram_health BETWEEN 0 AND 100 ) DEFAULT 100,
    monitor_health INTEGER CHECK ( monitor_health BETWEEN 0 AND 100 ) DEFAULT 100,
    memory_health INTEGER CHECK ( memory_health BETWEEN 0 AND 100 ) DEFAULT 100
);
