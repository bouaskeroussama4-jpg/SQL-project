WITH customer_totals AS ( 
SELECT  
A.customer_id, 
D.country, 
SUM(pay.amount) AS total_sum 
FROM customer A 
INNER JOIN payment pay ON A.customer_id = pay.customer_id 
INNER JOIN address B ON A.address_id = B.address_id 
INNER JOIN city C ON B.city_id = C.city_id 
INNER JOIN country D ON C.country_id = D.country_id 
GROUP BY A.customer_id, D.country 
), 
avg_total AS ( 
SELECT AVG(total_sum) AS avg_sum 
FROM customer_totals 
), 
top_customers AS ( 
SELECT ct.customer_id, ct.country 
FROM customer_totals ct 
CROSS JOIN avg_total a 
WHERE ct.total_sum > a.avg_sum 
) 
SELECT  
D.country, 
COUNT(DISTINCT A.customer_id) AS all_customer_count, 
COUNT(DISTINCT T.customer_id) AS top_customer_count 
FROM customer A 
INNER JOIN address B ON A.address_id = B.address_id 
INNER JOIN city C ON B.city_id = C.city_id 
INNER JOIN country D ON C.country_id = D.country_id 
LEFT JOIN top_customers T ON A.customer_id = T.customer_id 
GROUP BY D.country 
ORDER BY top_customer_count DESC 
LIMIT 10;
