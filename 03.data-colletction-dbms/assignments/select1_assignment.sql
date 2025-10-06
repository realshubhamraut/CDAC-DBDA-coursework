-- 1. Display all the information about all salespeople.
SELECT * FROM salespeople;

-- 2. Display a string "This is Exercise, Practice and Solution".
SELECT 'This is Exercise, Practice and Solution' AS message FROM dual;

-- 3. Display three numbers in three columns.
SELECT 10 AS num1, 20 AS num2, 30 AS num3 FROM dual;

-- 4. Display the sum of two numbers 10 and 15.
SELECT 10 + 15 AS sum_result FROM dual;

-- 5. Display the result of an arithmetic expression.
SELECT (100 + 50) * 2 AS expression_result FROM dual;

-- 6. Display names and commissions for all salespeople.
SELECT name, commission FROM salespeople;

-- 7. Display order date, salesman ID, order number, and purchase amount.
SELECT ord_date, salesman_id, ord_no, purch_amt FROM orders;

-- 8. Identify unique salespeople ID.
SELECT DISTINCT salesman_id FROM salespeople;

-- 9. Locate salespeople who live in 'Paris'.
SELECT name, city FROM salespeople WHERE city = 'Paris';

-- 10. Find customers whose grade is 200.
SELECT customer_id, cust_name, city, grade, salesman_id FROM customers WHERE grade = 200;

-- 11. Find orders delivered by salesperson with ID 5001.
SELECT ord_no, ord_date, purch_amt FROM orders WHERE salesman_id = 5001;

-- 12. Find Nobel Prize winner(s) for 1970.
SELECT year, subject, winner FROM nobel_win WHERE year = 1970;

-- 13. Find Nobel Prize winner in 'Literature' for 1970.
SELECT winner FROM nobel_win WHERE year = 1970 AND subject = 'Literature';

-- 14. Locate Nobel Prize winner 'Dennis Gabor'.
SELECT year, subject FROM nobel_win WHERE winner = 'Dennis Gabor';

-- 15. Find Nobel Prize winners in 'Physics' since 1950.
SELECT winner FROM nobel_win WHERE subject = 'Physics' AND year >= 1950;

-- 16. Find Nobel winners in 'Chemistry' between 1965 and 1975.
SELECT year, subject, winner, country FROM nobel_win
WHERE subject = 'Chemistry' AND year BETWEEN 1965 AND 1975;

-- 17. Prime Ministerial winners after 1972: Menachem Begin and Yitzhak Rabin.
SELECT * FROM nobel_win
WHERE year > 1972 AND winner IN ('Menachem Begin', 'Yitzhak Rabin');

-- 18. Winners whose first name matches 'Louis'.
SELECT year, subject, winner, country, category FROM nobel_win
WHERE winner LIKE 'Louis%';

-- 19. Combine winners in Physics 1970 and Economics 1971.
SELECT year, subject, winner, country, category FROM nobel_win
WHERE (year = 1970 AND subject = 'Physics') OR (year = 1971 AND subject = 'Economics');

-- 20. Nobel winners in 1970 excluding Physiology and Economics.
SELECT year, subject, winner, country, category FROM nobel_win
WHERE year = 1970 AND subject NOT IN ('Physiology', 'Economics');

-- 21. Physiology winners before 1971 and Peace winners on or after 1974.
SELECT year, subject, winner, country, category FROM nobel_win
WHERE (subject = 'Physiology' AND year < 1971)
   OR (subject = 'Peace' AND year >= 1974);

-- 22. Details of Nobel winner 'Johannes Georg Bednorz'.
SELECT year, subject, winner, country, category FROM nobel_win
WHERE winner = 'Johannes Georg Bednorz';

-- 23. Nobel winners for subjects not starting with 'P', ordered.
SELECT year, subject, winner, country, category FROM nobel_win
WHERE subject NOT LIKE 'P%'
ORDER BY year DESC, winner ASC;

-- 24. Nobel winners in 1970, Chemistry and Economics last.
SELECT year, subject, winner, country, category FROM nobel_win
WHERE year = 1970
ORDER BY CASE WHEN subject IN ('Chemistry', 'Economics') THEN 2 ELSE 1 END, subject;

-- 25. Products priced between Rs.200 and Rs.600.
SELECT pro_id, pro_name, pro_price, pro_com FROM products
WHERE pro_price BETWEEN 200 AND 600;

-- 26. Average price for manufacturer code 16.
SELECT AVG(pro_price) AS avg_price FROM products WHERE pro_com = 16;

-- 27. Display pro_name as 'Item Name' and pro_price as 'Price in Rs.'
SELECT pro_name AS "Item Name", pro_price AS "Price in Rs." FROM products;

-- 28. Items priced ≥ $250, ordered.
SELECT pro_name, pro_price FROM products
WHERE pro_price >= 250
ORDER BY pro_price DESC, pro_name ASC;

-- 29. Average price of items per company.
SELECT AVG(pro_price) AS avg_price, pro_com FROM products GROUP BY pro_com;

-- 30. Cheapest item(s).
SELECT pro_name, pro_price FROM products
WHERE pro_price = (SELECT MIN(pro_price) FROM products);

-- 31. Unique last names of employees.
SELECT DISTINCT emp_lname FROM employees;

-- 32. Employees with last name 'Snares'.
SELECT emp_idno, emp_fname, emp_lname, emp_dept FROM employees WHERE emp_lname = 'Snares';

-- 33. Employees in department 57.
SELECT emp_idno, emp_fname, emp_lname, emp_dept FROM employees WHERE emp_dept = 57;

-- 34. Customers with grade > 100.
SELECT customer_id, cust_name, city, grade, salesman_id FROM customers WHERE grade > 100;

-- 35. Customers in 'New York' with grade > 100.
SELECT customer_id, cust_name, city, grade, salesman_id FROM customers
WHERE city = 'New York' AND grade > 100;

-- 36. Customers from 'New York' or grade > 100.
SELECT customer_id, cust_name, city, grade, salesman_id FROM customers
WHERE city = 'New York' OR grade > 100;

-- 37. Customers from 'New York' or NOT grade > 100.
SELECT customer_id, cust_name, city, grade, salesman_id FROM customers
WHERE city = 'New York' OR grade <= 100;

-- 38. Customers NOT from 'New York' OR grade > 100.
SELECT customer_id, cust_name, city, grade, salesman_id FROM customers
WHERE city <> 'New York' OR grade > 100;

-- 39. Orders excluding specific conditions.
SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id FROM orders
WHERE NOT (
  ord_date = '2012-09-10' AND salesman_id > 5005 OR purch_amt > 1000
);

-- 40. Salespeople with commission between 0.10 and 0.12.
SELECT salesman_id, name, city, commission FROM salespeople
WHERE commission BETWEEN 0.10 AND 0.12;

-- 41. Orders with complex filter.
SELECT ord_no, purch_amt, ord_date, customer_id, salesman_id FROM orders
WHERE purch_amt < 200
   OR NOT (ord_date >= '2012-02-10' AND customer_id < 3009);

-- 42. Orders excluding specific combinations.
SELECT * FROM orders
WHERE NOT (
  ord_date = '2012-08-17' OR (customer_id > 3005 AND purch_amt < 1000)
);

-- 43. Orders with achieved/unachieved % of target 6000.
SELECT ord_no, purch_amt,
  ROUND((purch_amt / 6000) * 100, 2) AS achieved_pct,
  ROUND(100 - (purch_amt / 6000) * 100, 2) AS unachieved_pct
FROM orders
WHERE purch_amt > 3000;

-- 44. Employees with last name 'Dosni' or 'Mardy'.
SELECT emp_idno, emp_fname, emp_lname, emp_dept FROM employees
WHERE emp_lname IN ('Dosni', 'Mardy');

-- 45. Employees in department 47 or 63.
SELECT emp_idno, emp_fname, emp_lname, emp_dept FROM employees
WHERE emp_dept IN (47, 63);
