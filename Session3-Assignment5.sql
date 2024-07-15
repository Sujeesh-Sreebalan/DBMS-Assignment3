USE storefront;

/* Create a view displaying the order information (Id, Title, Price, 
Shopper’s name, Orderdate, Status) with latest ordered 
items should be displayed first for last 60 days.
*/

CREATE VIEW order_information AS 
SELECT u.id AS user_id, u.name AS name, u.username, p.id as product_id,
 p.name AS product_name, p.price, o.order_date, i.quantity, i.status
FROM users u 
INNER JOIN orders o ON o.user_id = u.id
INNER JOIN items i ON i.order_id = o.id
INNER JOIN product p ON p.id = i.product_id
WHERE DATEDIFF(CURDATE(), o.order_date) < 60; 


-- Use the above view to display the Products(Items) which are in ‘shipped’ state.
SELECT product_name, status
FROM order_information
WHERE status = 'Shipped';

-- Use the above view to display the top 5 most selling products.
SELECT product_name, SUM(quantity) AS products
FROM order_information
GROUP BY product_id
ORDER BY products DESC
LIMIT 5;

