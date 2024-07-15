USE storefront;

/* Consider a form where providing a Zip Code populates associated City and State. 
Create appropriate tables and relationships for the same and write a SQL
query for that returns a Resultset containing Zip Code, City Names and
States ordered by State Name and City Name.
*/
CREATE TABLE zipcode_details(
zipcode INT PRIMARY KEY,
city VARCHAR(40) NOT NULL,
state VARCHAR(40) NOT NULL
);

INSERT INTO zipcode_details
VALUES
(302001, 'jaipur', 'rajasthan'),
(305001, 'ajmer', 'rajasthan'),
(321001, 'bharatpur', 'rajasthan'),
(313001, 'udaipur', 'rajasthan'),
(411001, 'pune', 'maharashtra'),
(400008, 'mumbai', 'maharashtra'),
(282001, 'agra', 'utter pradesh');

SELECT zipcode, city, state
FROM zipcode_details
ORDER BY state, city;
