-- creating
CREATE TABLE "LIGHTNING_STRIKES_D" (
                                   id SERIAL PRIMARY KEY,
                                   strike_time TIME NOT NULL,
                                   min_power_affected INTEGER NOT NULL CHECK ( min_power_affected > 0 )
);

CREATE TABLE "WEB_D" (
                     id SERIAL PRIMARY KEY,
                     power INTEGER NOT NULL CHECK ( power >= 0 ),
                     strike_id INTEGER,
                     FOREIGN KEY (strike_id) REFERENCES "LIGHTNING_STRIKES_D" (id),
                     connected_routers VARCHAR(20)
);

CREATE TABLE "ROUTER_D" (
                        id SERIAL PRIMARY KEY,
                        connected_computers VARCHAR(20)
);

CREATE TABLE "COMPUTER_D" (
                          id SERIAL PRIMARY KEY,
                          components VARCHAR(100)
);

CREATE TABLE "HUMAN_D" (
                       id SERIAL PRIMARY KEY,
                       name VARCHAR(50) NOT NULL,
                       computer_id INTEGER,
                       FOREIGN KEY (computer_id) REFERENCES "COMPUTER_D" (id)
);

-- inserting
INSERT INTO "LIGHTNING_STRIKES_D" (strike_time, min_power_affected)
VALUES ('10:00:00', 450),
       ('10:45:00', 370);

INSERT INTO "WEB_D" (power, strike_id, connected_routers)
VALUES (350, null, '1, 2'),
       (400, 2, '3');

INSERT INTO "ROUTER_D" (connected_computers)
VALUES ('1, 2'),
       ('3'),
       ('4, 5');

INSERT INTO "COMPUTER_D" (components)
VALUES ('Intel core i10, windows, samsung, samsung, HDD 0'),
       ('AMD, TempleOS, amd, asus, SSD 3000'),
       ('Mediatek, Linux, hyperx, xiaomi, 10'),
       (null),
       (null);

INSERT INTO "HUMAN_D" (computer_id, name)
VALUES (1, 'Арнольд'),
       (2, 'Недри');
