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
    UPDATE "COMPUTERS"
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
    WHERE web_id = affected_web;
    RETURN NULL;
end;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER lightning_strike
    AFTER INSERT
    ON "LIGHTNING_STRIKES"
    FOR EACH ROW
EXECUTE FUNCTION damage_computers();


