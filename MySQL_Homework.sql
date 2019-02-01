USE sakila;

-- 1a.First and Last names of all actors from the table actor
SELECT first_name, last_name FROM actor;
-- 1b.First and Last name of each actor in a single column in upper case letters. Name the column Actor Name
SELECT CONCAT(UPPER(first_name), ' ', UPPER(last_name)) AS 'Actor Name' FROM actor;

-- 2a. find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe."
SELECT actor_id, first_name, last_name FROM actor WHERE first_name='Joe';
-- 2b All actors whose last name contain the letters GEN
SELECT actor_id, first_name, last_name FROM actor WHERE last_name LIKE '%GEN%';
-- 2c. All actors whose last names contain the letters LI. Order the rows by last name and first name.
SELECT actor_id, first_name, last_name FROM actor WHERE last_name LIKE '%LI%' ORDER BY last_name, first_name ASC;
-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id, country FROM country WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a. Create a column in the table actor named description and use the data type BLOB
ALTER TABLE actor ADD COLUMN description BLOB AFTER last_update;
-- 3b. Delete the description column.
ALTER TABLE actor DROP COLUMN description;

-- 4a. List the last names of actors, as well as how many actors have that last name.
SELECT last_name, COUNT(last_name) AS 'Count Actor same Last Name' FROM actor GROUP BY last_name;
-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT last_name, COUNT(last_name) AS 'Count Actor same Last Name' FROM actor
GROUP BY last_name HAVING COUNT(last_name)>=2;
-- 4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS
UPDATE actor SET first_name='HARPO' WHERE  first_name='GROUCHO' AND last_name='WILLIAMS';
-- 4d. If the first name of the actor is currently HARPO, change it to GROUCHO
UPDATE actor SET first_name='GROUCHO' WHERE  first_name='HARPO' AND last_name='WILLIAMS';

-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
SHOW CREATE TABLE address;

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member
SELECT first_name, last_name, address 
FROM staff JOIN address ON (staff.address_id=address.address_id);
-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005
SELECT first_name, last_name, SUM(amount) AS 'Amount by Member'
FROM staff 
JOIN payment ON (staff.staff_id=payment.staff_id) 
WHERE payment_date LIKE '2005-08-%'
GROUP BY payment.staff_id;
-- 6c. List each film and the number of actors who are listed for that film. Use inner join
SELECT title, COUNT(actor_id) AS 'Number of Actors'
FROM film
INNER JOIN film_actor ON (film.film_id=film_actor.film_id)
GROUP BY title;
-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT title, COUNT(inventory_id) AS 'Number of Copies'
FROM film
JOIN inventory ON (film.film_id=inventory.film_id)
WHERE title='Hunchback Impossible'
GROUP BY title;
-- 6e. list the total paid by each customer. List the customers alphabetically by last name
SELECT first_name, last_name, SUM(amount) AS 'Total Paid'
FROM customer
JOIN payment ON (customer.customer_id=payment.customer_id)
GROUP BY customer.customer_id
ORDER BY last_name ASC;