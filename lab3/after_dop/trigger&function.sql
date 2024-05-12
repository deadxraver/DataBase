SET SEARCH_PATH = "schema_after_dop";

CREATE OR REPLACE FUNCTION damage_computers()
    RETURNS TRIGGER AS
$$
DECLARE
    affected_web INTEGER = (SELECT (count(*) * random() + 1)::INTEGER
                            FROM "WEB") ;
    damage       INTEGER = (new.strength * random() * (SELECT "WEB".power
                                                       FROM "WEB"
                                                       WHERE id = affected_web)) / 1000;
BEGIN
    UPDATE "COMPONENTS_HEALTH"
    SET ram_health     = (
        CASE
            WHEN random() > 0.5
                THEN (CASE WHEN ram_health - damage > 0 THEN ram_health - damage ELSE 0 END)
            ELSE ram_health END
        ),
        monitor_health = (
            CASE
                WHEN random() > 0.5
                    THEN (CASE WHEN monitor_health - damage > 0 THEN monitor_health - damage ELSE 0 END)
                ELSE monitor_health END
            ),
        memory_health  = (
            CASE
                WHEN random() > 0.5
                    THEN (CASE WHEN memory_health - damage > 0 THEN memory_health - damage ELSE 0 END)
                ELSE memory_health END
            )
    WHERE EXISTS(SELECT *
                 FROM "COMPUTERS"
                 WHERE "COMPUTERS".id = "COMPONENTS_HEALTH".computer_id
                   AND "COMPUTERS".web_id = affected_web);
    RETURN NULL;
end;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER lightning_strike
    AFTER INSERT
    ON "LIGHTNING_STRIKES"
    FOR EACH ROW
EXECUTE FUNCTION damage_computers();


-- some new triggers & functions
CREATE OR REPLACE FUNCTION add_components_info()
    RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO "COMPONENTS_HEALTH" (computer_id)
    VALUES (new.id);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION remove_components_info()
    RETURNS TRIGGER AS
$$
BEGIN
    DELETE FROM "COMPONENTS_HEALTH" WHERE computer_id = old.id;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER new_computer
    AFTER INSERT
    ON "COMPUTERS"
    FOR EACH ROW
EXECUTE FUNCTION add_components_info();


CREATE OR REPLACE TRIGGER computer_disappears
    BEFORE DELETE
    ON "COMPUTERS"
    FOR EACH ROW
EXECUTE FUNCTION remove_components_info();

