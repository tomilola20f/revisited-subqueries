use sakila;

#Select the first name, last name, and email address of all the customers who have rented a movie.

SELECT customer.first_name, customer.last_name, customer.email from customer
INNER JOIN rental  
ON rental.customer_id = customer.customer_id
GROUP BY customer.first_name, customer.last_name, customer.email ;

#What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

SELECT CONCAT(customer.customer_id, ' ', customer.first_name , ' ', customer.last_name) name_id,  AVG(payment.amount) AS avg_payment FROM customer  
LEFT JOIN rental  
ON rental.customer_id = customer.customer_id
LEFT JOIN payment 
ON payment.rental_id = rental.rental_id
GROUP BY name_id;

#Select the name and email address of all the customers who have rented the "Action" movies.

SELECT customer.first_name, customer.last_name, customer.email FROM customer  
LEFT JOIN rental  ON rental.customer_id = customer.customer_id
LEFT JOIN inventory ON inventory.inventory_id = rental.inventory_id
LEFT JOIN film_category ON film_category.film_id = inventory.film_id
LEFT JOIN category ON category.category_id = film_category.category_id 
WHERE category.name = 'Action'
GROUP BY customer.first_name, customer.last_name, customer.email;

#Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.

SELECT *, 
CASE WHEN payment.amount BETWEEN 2 and 4 then 'Medium'
     WHEN payment.amount < 2 THEN 'Low'
     ELSE 'High' 
END AS category
FROM payment;