DROP TABLE IF EXISTS rent;

CREATE TABLE rent (
    suburb       TEXT,
    region       TEXT,
    leases       INTEGER,
    median_rent  NUMERIC(7, 2),
    dwelling     TEXT,
    bedrooms     TEXT,
    low_sample   BOOLEAN,
    quarter      TEXT
);