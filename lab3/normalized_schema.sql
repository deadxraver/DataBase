-- creating
CREATE TABLE lightning_strikes (
                                   id SERIAL PRIMARY KEY,
                                   strike_time TIME NOT NULL,
                                   min_power_affected INTEGER NOT NULL CHECK ( min_power_affected > 0 )
);

CREATE TABLE web (
                     id SERIAL PRIMARY KEY,
                     power INTEGER NOT NULL CHECK ( power >= 0 )
);

CREATE TABLE router (
                        id SERIAL PRIMARY KEY,
                        web_id INTEGER NOT NULL,
                        FOREIGN KEY (web_id) REFERENCES web (id)
);

CREATE TABLE ram_info (
                          name VARCHAR(50) UNIQUE,
                          capacity INTEGER CHECK ( capacity > 0 ),
                          speed INTEGER CHECK ( speed > 0 )
);

CREATE TABLE computer (
                          id SERIAL PRIMARY KEY,
                          CPU VARCHAR(50),
                          OS VARCHAR(50),
                          RAM VARCHAR(50) REFERENCES ram_info (name),
                          monitor VARCHAR(50),
                          memory VARCHAR(50),
                          router_id INTEGER NOT NULL,
                          FOREIGN KEY (router_id) REFERENCES router (id)
);

CREATE TABLE human (
                       id SERIAL PRIMARY KEY,
                       name VARCHAR(50) NOT NULL,
                       computer_id INTEGER,
                       FOREIGN KEY (computer_id) REFERENCES computer (id)
);

-- inserting
INSERT INTO lightning_strikes (strike_time, min_power_affected)
VALUES ('10:00:00', 450),
       ('10:45:00', 370);

INSERT INTO web (power)
VALUES (350),
       (400);

INSERT INTO router (web_id)
VALUES (1),
       (1),
       (2);

INSERT INTO ram_info (name, capacity, speed)
VALUES ('samsung', 8192, 3200),
       ('amd', 16384, 3200),
       ('hyperx', 4096, 3200);

INSERT INTO computer (cpu, os, ram, monitor, memory, router_id)
VALUES ('Intel core i10', 'windows', 'samsung', 'samsung', 'HDD 0', 1),
       ('AMD', 'TempleOS', 'amd', 'asus', 'SSD 3000', 1),
       ('Mediatek', 'Linux', 'hyperx', 'xiaomi', '10', 2),
       (null, NULL, Null, nULL, nUlL, 3),
       (null, null, null, null, null, 3);

INSERT INTO human (computer_id, name)
VALUES (1, 'Арнольд'),
       (2, 'Недри');

INSERT INTO lightning_strikes (strike_time, min_power_affected) VALUES (now(), 10);