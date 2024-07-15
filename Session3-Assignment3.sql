USE storefront;

-- Display Shopper’s information along with number of orders he/she placed during last 30 days.
SELECT u.id, u.name, COUNT(o.id) AS orders_placed
FROM users u
INNER JOIN orders o
ON u.id = o.user_id
WHERE DATEDIFF(NOW(), o.order_date) < 30
GROUP BY o.user_id;

-- Display the top 10 Shoppers who generated maximum number of revenue in last 30 days.
SELECT u.id, u.name, SUM(o.total_amount) AS revenue
FROM users u
INNER JOIN orders o
ON u.id = o.user_id
WHERE DATEDIFF(NOW(), o.order_date) < 30
GROUP BY o.user_id
ORDER BY revenue DESC
LIMIT 10;

-- Display top 20 Products which are ordered most in last 60 days along with numbers.
SELECT p.id, p.name, SUM(i.quantity) as ordered_most
FROM product p
INNER JOIN items i
ON i.product_id = p.id
INNER JOIN orders o
ON o.id = i.order_id
WHERE DATEDIFF(NOW(), o.order_date)  < 60
GROUP BY i.product_id
ORDER BY ordered_most DESC
LIMIT 20;

-- Display Monthly sales revenue of the StoreFront for last 6 months. It should display each month’s sale.
SELECT MONTH(order_date) as month, SUM(total_amount) 
FROM orders
WHERE order_date > (CURDATE() - INTERVAL 6 MONTH)
GROUP BY month;

-- Mark the products as Inactive which are not ordered in last 90 days.
ALTER TABLE product
ADD COLUMN product_state VARCHAR(20) DEFAULT 'active';
SET SQL_SAFE_UPDATES = 0;
UPDATE product p
SET p.product_state = 'inactive'
WHERE p.id NOT IN(SELECT DISTINCT i.product_id
				  FROM items i
                  INNER JOIN orders o
                  ON i.order_id = o.id
                  WHERE DATEDIFF(CURDATE(), o.order_date) < 90);

-- Given a category search keyword, display all the Products present in this category/categories.
SELECT p.id, p.name
FROM category c
INNER JOIN product_category_relation pcr
ON c.id = pcr.category_id
INNER JOIN product p
ON p.id = pcr.product_id
WHERE c.name = 'mobile';

-- Display top 10 Items which were cancelled most.
SELECT p.id, p.name, COUNT(i.id) as items_cancelled
FROM product p
INNER JOIN items i
ON p.id = i.product_id
WHERE i.status = 'Cancelled'
GROUP BY i.product_id
ORDER BY items_cancelled DESC
LIMIT 10;

