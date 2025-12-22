CREATE TYPE vehicle_status AS ENUM ('available','rented','maintenance');

CREATE TYPE booking_status AS ENUM('pending','confirmed','completed');

CREATE TYPE vehicle_type AS ENUM('car','bike','truck');

CREATE TABLE "Users" (
    "user_id" bigint,
    "role" varchar(50),
    "name" varchar(50),
    "email" varchar(50) unique,
    "password" varchar(50),
    "phone_number" varchar(50),
    PRIMARY KEY ("user_id")
);

CREATE TABLE "Vehicles" (
    "vehicle_id" bigint,
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

SELECT * FROM "Users";

SELECT * FROM "Vehicles";

SELECT * FROM "Bookings";

INSERT INTO
    "Users" (
        user_id,
        role,
        name,
        email,
        password,
        phone_number
    )
VALUES (
        1,
        'customer',
        'Arif Hossain',
        'arif@email.com',
        'pass123',
        '01711223344'
    ),
    (
        2,
        'customer',
        'Nusrat Jahan',
        'nusrat@email.com',
        'secure456',
        '01822334455'
    );

INSERT INTO
    "Vehicles" (
        vehicle_id,
        type,
        model,
        registration_number,
        rental_price,
        status
    )
VALUES (
        101,
        'car',
        'Toyota Corolla',
        'DHAKA-METRO-123',
        3000,
        'available'
    ),
    (
        102,
        'bike',
        'Yamaha R15',
        'DHAKA-METRO-456',
        1200,
        'available'
    ),
    (
        103,
        'truck',
        'Tata LPT',
        'DHAKA-METRO-789',
        8000,
        'maintenance'
    );

INSERT INTO
    "Bookings" (
        booking_id,
        user_id,
        vehicle_id,
        start_date,
        end_date,
        status,
        total_cost
    )
VALUES (
        501,
        1,
        101,
        '2025-01-01',
        '2025-01-03',
        'confirmed',
        6000
    ),
    (
        502,
        2,
        102,
        '2025-01-05',
        '2025-01-05',
        'pending',
        1200
    );

--? Retrieve booking information along with Customer name and Vehicle name.
SELECT
    b.booking_id,
    u.name AS customer_name,
    v.model AS vehicle_name,
    b.start_date,
    b.end_date,
    b.status
FROM
    "Bookings" AS b
    JOIN "Users" AS u USING (user_id)
    JOIN "Vehicles" AS v USING (vehicle_id);

--? Find all vehicles that have never been booked.