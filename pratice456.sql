   SQL Pratice
--Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com.

  WITH t1 AS (
  SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') - 1 ) AS first_name, RIGHT(primary_poc, length(primary_poc) - strpos(primary_poc, ' ')) as last_name, name
  FROM accounts)
  select first_name, last_name, concat( first_name, '.', last_name, '@', name, '.com')
  from t1;
            
 --We would also like to create an initial password, which they will change after their first log in. The first password will be the first letter of the primary_poc's first name (lowercase), then the last letter of their first name (lowercase), the first letter of their last name (lowercase), the last letter of their last name (lowercase), the number of letters in their first name, the number of letters in their last name, and then the name of the company they are working with, all capitalized with no spaces

WITH t1 AS (
SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') - 1 ) AS first_name, RIGHT(primary_poc, length(primary_poc) - strpos(primary_poc, ' ')) as last_name, name
FROM accounts)
SELECT concat(left(lower(first_name),1), right(lower(first_name),1), left(lower(last_name),1), right(lower(last_name),1), length(first_name), length(last_name), replace(upper(name), ' ', '')
FROM t1
Group by name,first_name,last_name;         

-- Write a query to display for each order, the account ID, the total amount of the order, and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 or more, or smaller than $3000.              

SELECT a.id, o.total_amt_usd, CASE WHEN total_amt_usd >= 3000 THEN 'Large' ELSE 'Small' END AS scal
FROM accounts AS a
INNER JOIN orders AS o
ON a.id = o.account_id; 


--Write a query to display the number of orders in each of three categories, based on the total number of items in each order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.
SELECT CASE WHEN total >= 2000 THEN 'At least 2000' 
            WHEN total > 1000 AND total < 2000 THEN 'Between 1000 and 2000' ELSE 'Leass than 1000' END AS categories, COUNT(*) AS order_count
FROM orders
GROUP BY 1;

--We would like to understand 3 different levels of customers based on the amount associated with their purchases. The top-level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. Provide a table that includes the level associated with each account. You should provide the account name, the total sales of all orders for the customer, and the level. Order with the top spending customers listed first.
SELECT a.name, SUM(o.total_amt_usd), CASE WHEN SUM (total_amt_usd) > 200000 THEN 'toplevel' 
                             WHEN SUM (total_amt_usd) > 100000 AND SUM (total_amt_usd) < 200000 THEN 'seondlevel'
                             ELSE 'lowestlevel' END AS levels 
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
GROUP BY 1
ORDER BY 3 DESC;

--We would like to understand 3 different levels of customers based on the amount associated with their purchases. The top-level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second level is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. Provide a table that includes the level associated with each account. You should provide the account name, the total sales of all orders for the customer, and the level. Order with the top spending customers listed first.
SELECT a.name, SUM(o.total_amt_usd), CASE WHEN SUM (total_amt_usd) > 200000 THEN 'toplevel' 
                             WHEN SUM (total_amt_usd) > 100000 AND SUM (total_amt_usd) < 200000 THEN 'seondlevel'
                             ELSE 'lowestlevel' END AS levels 
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
WHERE occurred_at Between '2016-01-01' AND '2018-01-01'
GROUP BY 1
ORDER BY 3 DESC;
              
--Try using LIMIT yourself below by writing a query that displays all the data in the occurred_at, account_id, and channel columns of the web_events table, and limits the output to only the first 15 rows.
SELECT occurred_at,account_id,channel
FROM web_events
LIMIT 15; 
              
--Write a query to return the 10 earliest orders in the orders table. Include the id, occurred_at, and total_amt_usd.
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at 
LIMIT 10;
              
--Write a query to return the top 5 orders in terms of the largest total_amt_usd. Include the id, account_id, and total_amt_usd.
SELECT total_amt_usd, id, account_id 
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;
              
--Write a query to return the lowest 20 orders in terms of the smallest total_amt_usd. Include the id, account_id, and total_amt_usd.
SELECT id, account_id, total_amt_usd
FROM orders 
ORDER BY total_amt_usd
LIMIT 20;
              
--Write a query that displays the order ID, account ID, and total dollar amount for all the orders, sorted first by the account ID (in ascending order), and then by the total dollar amount (in descending order).
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC;
              
--Now write a query that again displays order ID, account ID, and total dollar amount for each order, but this time sorted first by total dollar amount (in descending order), and then by account ID (in ascending order).
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY  total_amt_usd DESC, account_id;
              

