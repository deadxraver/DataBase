INSERT INTO "WEB" (power)
VALUES (100),
       (150),
       (950);

INSERT INTO "RAMS" (name, capacity)
VALUES ('someRam1', 2048),
       ('some_ram_2', 1024),
       ('whatever 3', 4096);

INSERT INTO "MEMORIES" (name, capacity)
VALUES ('ssd', 1048576),
       ('someMemory', 16384);

INSERT INTO "MONITORS" (name, height, length)
VALUES ('LG', 1024, 1024),
       ('SAMSUNG', 720, 1920),
       ('SAMSUNG', 1920, 2048);

INSERT INTO "COMPUTERS" (os_name, ram_id, monitor_id, memory_id, web_id)
VALUES ('Ubuntu', 1, 1, 1, 1),
       ('Windows', 1, 3, 2, 3),
       ('TempleOS', 2, 2, 2, 2),
       ('Debian', 3, 3, 2, 3);

INSERT INTO "PEOPLE" (name, computer_id)
VALUES ('Недри', 1),
       ('Арнольд', 3);
