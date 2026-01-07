WITH top_countries AS ( 
    SELECT D.country 
    FROM customer A 
    INNER JOIN address B ON A.address_id = B.address_id 
    INNER JOIN city C ON B.city_id = C.city_id 
    INNER JOIN country D ON C.country_id = D.country_id 
    GROUP BY D.country 
    ORDER BY COUNT(A.customer_id) DESC 
    LIMIT 10 
), 
top_cities AS ( 
    SELECT C.city 
    FROM customer A 
    INNER JOIN address B ON A.address_id = B.address_id 
    INNER JOIN city C ON B.city_id = C.city_id 
    INNER JOIN country D ON C.country_id = D.country_id 
    WHERE D.country IN (SELECT country FROM top_countries) 
    GROUP BY D.country, C.city 
    ORDER BY COUNT(A.customer_id) DESC 
    LIMIT 10 
), 
customer_totals AS ( 
    SELECT  
        A.customer_id, 
        A.first_name, 
        A.last_name, 
        D.country, 
        C.city, 
        SUM(pay.amount) AS total_amount_paid 
    FROM customer A 
 
 
 
    INNER JOIN payment pay ON A.customer_id = pay.customer_id 
    INNER JOIN address B ON A.address_id = B.address_id 
    INNER JOIN city C ON B.city_id = C.city_id 
    INNER JOIN country D ON C.country_id = D.country_id 
    WHERE C.city IN (SELECT city FROM top_cities) 
    GROUP BY A.customer_id, A.first_name, A.last_name, D.country, C.city 
    ORDER BY total_amount_paid DESC 
    LIMIT 5 
) 
SELECT AVG(total_amount_paid) AS average_amount_paid 
FROM customer_totals; 
