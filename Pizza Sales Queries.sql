SELECT * FROM pizza_sales;

SELECT SUM(total_price)
AS total_revenue
FROM pizza_sales;

SELECT SUM(total_price) / COUNT(DISTINCT order_id)
AS average_order_value
FROM pizza_sales;

SELECT SUM(quantity)
AS total_pizza_sold
FROM pizza_sales;

SELECT COUNT(DISTINCT order_id)
AS total_orders
FROM pizza_sales;

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS average_pizza_per_order
FROM pizza_sales;

SELECT HOUR(order_time) AS order_hours, SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY order_hours
ORDER BY order_hours;

/* Change order_date to DATE and order_time to TIME */
/* Because order_date is not yyyy-MM-dd change it into that type to easily use the query function WEEK */
SET SQL_SAFE_UPDATES = 0;

UPDATE pizza_sales
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y')
WHERE order_date LIKE '__-__-____';

SET SQL_SAFE_UPDATES = 1;

ALTER TABLE `Pizza Db`.`pizza_sales` 
CHANGE COLUMN `order_date` `order_date` DATE NULL DEFAULT NULL,
CHANGE COLUMN `order_time` `order_time` TIME NULL DEFAULT NULL;

SELECT WEEK(order_date, 1) AS week_number, YEAR(order_date) AS order_year, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY week_number, order_year
ORDER BY week_number, order_year;

SELECT pizza_category, 
CAST(
	SUM(total_price) AS DECIMAL(10,2)
    ) AS total_sales, 
CAST(
	SUM(total_price) * 100  / (SELECT SUM(total_price) FROM pizza_sales)AS DECIMAL(10,2)
    ) AS percentage_of_sales
FROM pizza_sales
GROUP BY pizza_category;

SELECT pizza_size,
CAST(
	SUM(total_price) AS DECIMAL(10,2)
) AS total_sales,
CAST(
	SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)
    ) AS percentage_of_sales
FROM pizza_sales
GROUP BY pizza_size;

/* By REVENUE */
SELECT pizza_name, 
CAST(SUM(total_price)AS DECIMAL(10,2)) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 5;

SELECT pizza_name, 
CAST(SUM(total_price)AS DECIMAL(10,2)) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC
LIMIT 5;

/* By QUANTITY */
SELECT pizza_name, SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas_sold DESC
LIMIT 5;

SELECT pizza_name, SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas_sold ASC
LIMIT 5;

/* By TOTAL ORDERS */
SELECT pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC
LIMIT 5;

SELECT pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders ASC
LIMIT 5;

SELECT
	pizza_name,
    CAST(
		SUM(total_price) AS DECIMAL(10,2)
        ) AS total_revenue,
	SUM(quantity) AS total_quantity,
    COUNT(DISTINCT order_id) AS total_orders
FROM
	pizza_sales
GROUP BY
	pizza_name
ORDER BY total_revenue DESC
LIMIT 5;