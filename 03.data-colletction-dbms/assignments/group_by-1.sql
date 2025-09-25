-- 1. write a SQL query to calculate the total purchase amount of all orders. Return total purchase amount.

select order_id, round(sum(unit_price)) as total_amt from order_details
group by order_id;


-- 2. write a SQL query to calculate the average purchase amount of all orders. Return average purchase amount.

select * from orders;
select * from order_details

-- 3. 