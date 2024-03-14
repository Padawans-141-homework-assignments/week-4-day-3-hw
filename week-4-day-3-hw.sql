--Question 1: List all customers who live in Texas
SELECT district, CONCAT(first_name, ' ', last_name) AS customer
FROM address
JOIN customer
ON address.address_id = customer.address_id
WHERE district = 'Texas'

--Question 2: Get all payments above $6.99 with the Customer's Full Name
SELECT amount, CONCAT(first_name, ' ', last_name) AS customer 
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99

--Question 3: Show all customers names who have made payments over $175
SELECT customer, total_sum
FROM
(SELECT SUM(amount) AS total_sum, CONCAT(first_name, ' ', last_name) AS customer 
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer
)
WHERE total_sum > 175

--Question 4: List all customers that live in Nepal
--I think the result should be blank because I didn't see any Nepal in the
--city table.
SELECT city, CONCAT(first_name, ' ', last_name) AS customer
FROM city
JOIN address
ON city.city_id = address.city_id
JOIN customer
ON address.address_id = customer.address_id
WHERE city = 'Nepal'

--Question 5: Which staff member had the most transactions?
SELECT staff.staff_id AS staff_mem, COUNT(rental_date) AS transaction
FROM staff
JOIN rental
ON rental.staff_id = staff.staff_id
GROUP BY staff.staff_id
LIMIT 1

--Question 6: How many movies of each rating are there?
SELECT rating, COUNT(rating) AS movie_amnt
FROM film
GROUP BY rating
ORDER BY movie_amnt DESC

--Question 7: Show all customers who have made a single payment above $6.99
SELECT customer ,COUNT(DISTINCT payment_amt) AS one_purchase
FROM
(SELECT CONCAT(first_name, ' ', last_name) AS customer, amount as payment_amt
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer, payment_amt
HAVING COUNT(*) = 1 AND MAX(amount) > 6.99
)
GROUP BY customer 
HAVING COUNT(DISTINCT payment_amt) = 1;

--Question 8. How many free rentals did our stores give away?
SELECT COUNT(amount) AS free_rental
FROM payment
WHERE amount = 0