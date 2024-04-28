-- функция
CREATE OR REPLACE FUNCTION affect_computers() RETURNS trigger AS
$BODY$
BEGIN
    UPDATE computer SET (cpu, os, monitor, memory) = null
    WHERE computer.id = (
        SELECT computer.id FROM computer
                  LEFT JOIN router ON computer.router_id = router.id
                           LEFT JOIN web ON router.web_id = web.id
                           WHERE web.power >= tg_argv[2]::integer
    );
END;
$BODY$ LANGUAGE plpgsql;
-- computer.router_id = router.id; router.web_id = web.id; web.power >= lightning_strikes.min_power_affected

-- триггер
CREATE OR REPLACE TRIGGER bolt
    AFTER INSERT OR UPDATE ON lightning_strikes
    FOR EACH ROW
EXECUTE FUNCTION affect_computers();