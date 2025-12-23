# Vehicle Rental System Database Design And Some Query Questions & Answers With Postgres Sql.

First we will create a database with CREATE DATABASE vehicle rental databse this command.
Then we follow same procedure and create three table that's Users, Vehicles and Bookings.
We will run our all code is vs code. Then read the problem and first will will make a ER diagram in any tools. So we use lucid.app for making this ER diagram. This diagram link is bellow.

ERD Link: https://lucid.app/lucidchart/02f6e6a3-d6fd-41e4-a3c2-52437d46799e/edit?viewport_loc=-3144%2C-750%2C2298%2C1038%2C0_0&invitationId=inv_6c35a526-8e70-425a-a84f-82f7cd9e480c

Now will solve this problem.

Question_1: Retrieve booking information along with: Customer name, Vehicle name.
Ans:
If we want solve this problem we are use 'Inner Join'. First we join Users and Vehicles table and show all requered data like User role (Admin or Customer), Name, email, password, phone number Each email must be unique (no duplicate accounts).

Question_2: Find all vehicles that have never been booked.
Ans:
This problem is very essay. Just we use a simple logic like which vehicles status is 'rented' we just ignore one and show all vehicles. Command is: select * from "Vehicles" as v where v.status <> 'rented';

Question_3: Retrieve all available vehicles of a specific type (e.g. cars).
Ans:
Here we will use a function. The function get one paramitter and this is vehicles type. We just make a function and write a simple query such as select, where etc.

Question_4: Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.
Ans:
This question is hard but very simple. just we will used 'group by and having' and join 'Booking and Vehicles' tables. There show only booking vehicles name and how much booking in this single vehicles.
