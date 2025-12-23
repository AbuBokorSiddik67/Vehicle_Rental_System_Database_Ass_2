--? Table Creation...
CREATE TYPE vehicle_status AS ENUM ('available','rented','maintenance');

CREATE TYPE booking_status AS ENUM('pending','confirmed','completed','cancelled');

CREATE TYPE vehicle_type AS ENUM('car','bike','truck');

CREATE TABLE "Users" (
    "user_id" bigint,
    "role" varchar(50),
    "name" varchar(50),
    "email" varchar(50) unique,
    "password" varchar(50),
    "phone" varchar(50),
    PRIMARY KEY ("user_id")
);

CREATE TABLE "Vehicles" (
    "vehicle_id" bigint,
    "name" varchar(100),
    "type" vehicle_type,
    "model" varchar(50),
    "registration_number" varchar(100) unique,
    "rental_price" bigint,
    "status" vehicle_status,
    PRIMARY KEY ("vehicle_id")
);

CREATE TABLE "Bookings" (
    "booking_id" bigint,
    "user_id" bigint REFERENCES "Users" (user_id),
    "vehicle_id" bigint REFERENCES "Vehicles" (vehicle_id),
    "start_date" date,
    "end_date" date,
    "status" booking_status,
    "total_cost" bigint,
    PRIMARY KEY ("booking_id"),
    CONSTRAINT "FK_Bookings_user_id" FOREIGN KEY ("user_id") REFERENCES "Users" ("user_id"),
    CONSTRAINT "FK_Bookings_vehicle_id" FOREIGN KEY ("vehicle_id") REFERENCES "Vehicles" ("vehicle_id")
);

--? Users Data
SELECT
    user_id,
    name,
    email,
    phone_number,
    role
FROM "Users";

--? Vehicles Data
SELECT * FROM "Vehicles";

--? Bookings Data
SELECT * FROM "Bookings";

--?-1 Retrieve booking information along with Customer name and Vehicle name.
SELECT
    b.booking_id,
    u.name AS customer_name,
    v.name AS vehicle_name,
    b.start_date,
    b.end_date,
    b.status
FROM
    "Bookings" AS b
    INNER JOIN "Users" AS u USING (user_id)
    INNER JOIN "Vehicles" AS v USING (vehicle_id);

--?-2 Find all vehicles that have never been booked.
SELECT *
FROM "Vehicles" as v
WHERE
    NOT EXISTS (
        SELECT 1
        FROM "Vehicles" as v2
        WHERE
            v.vehicle_id = v2.vehicle_id
            AND v.status = 'rented'
    );

--?-3 Retrieve all available vehicles of a specific type (e.g. cars).
CREATE OR REPLACE FUNCTION search_vehicle_type(type_search vehicle_type)
RETURNS SETOF "Vehicles" AS
$$
BEGIN
RETURN QUERY
SELECT * FROM "Vehicles" AS v WHERE v.type=type_search;
END;
$$ LANGUAGE PLPGSQL;

SELECT * FROM search_vehicle_type ('bike');

--?-4 Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.
SELECT
    v.name as vehicle_name,
    COUNT(*) as total_bookings
FROM "Bookings" as b
    INNER JOIN "Vehicles" as v USING (vehicle_id)
GROUP BY
    v.vehicle_id
HAVING
    COUNT(*) > 2;