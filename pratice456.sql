DA 103.3 ADVANCE SQL
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


