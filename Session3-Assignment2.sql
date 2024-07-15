USE storefront;

-- Display the list of products (Id, Title, Count of Categories) which fall in more than one Categories.
SELECT pcr.product_id, COUNT(pcr.product_id) as count_of_categories, p.name
FROM product_category_relation pcr
INNER JOIN product p
ON p.id = pcr.product_id
GROUP BY pcr.product_id
HAVING COUNT(pcr.product_id) > 1;

-- Display Count of products as per below price range:
SELECT '0-1000', COUNT(id) AS count 
FROM  product
WHERE price BETWEEN 0 AND 1000
UNION
SELECT '1000-10000', COUNT(id) AS count 
FROM  product
WHERE price BETWEEN 1000 AND 10000
UNION
SELECT '10000-50000', COUNT(id) AS count 
FROM  product
WHERE price BETWEEN 10000 AND 50000;

-- Display the Categories along with number of products under each category.
SELECT c.id, c.name, COUNT(pcr.product_id) as count_of_product
FROM category c
INNER JOIN product_category_relation pcr
ON c.id = pcr.category_id
GROUP BY c.id;
