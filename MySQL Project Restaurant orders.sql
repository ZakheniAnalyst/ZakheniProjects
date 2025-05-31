SELECT * FROM restaurant.order_details;
SELECT * FROM restaurant.menu_items;

1.
ALTER TABLE restaurant.order_details
RENAME COLUMN ï»¿order_details_id TO menu_item_id;

2.
-- items ordered placed after midday
SELECT mi.item_name, od.order_time
FROM restaurant.menu_items mi
JOIN restaurant.order_details od
ON mi.menu_item_id = od.menu_item_id
WHERE order_time > '12:00:00 PM'
ORDER BY order_time DESC ;

3.
-- Q. Show all the Italian items ordered before 1 March 2023
SELECT mi.item_name, mi.category, od.order_date
FROM restaurant.menu_items mi
JOIN restaurant.order_details od
ON od.menu_item_id = mi.menu_item_id
WHERE category = "Italian" AND order_date < "1/3/23";

4.
-- Q. Count the number of categories 
SELECT DISTINCT(category), COUNT(*) as Categories
FROM restaurant.menu_items
GROUP BY category
ORDER BY Categories DESC;
-- A. The most number of categories came from Mexican and Italian, tied at 9.

5.
-- Q. Which category has the highest total price
SELECT ROUND(SUM(price),2) total_price, category
FROM restaurant.menu_items
GROUP BY category
ORDER BY total_price DESC;
-- A. Italian has the highest total price out of the 4.

6.
-- Q. Average Price per category / using GROUP BY and Window Function (Partition By)
SELECT category, ROUND(avg(price),2) avg_price
FROM restaurant.menu_items
GROUP BY category
ORDER BY avg_price DESC;

7.
SELECT category, 
ROUND(AVG(price) OVER(PARTITION BY category),2) as category_avg_price
FROM restaurant.menu_items;

8.
-- Q. How many items cost more than the average price?
SELECT COUNT(*) as items_above_average
FROM restaurant.menu_items
WHERE price > 
(SELECT ROUND(AVG(price),2) FROM restaurant.menu_items);
-- A. There are 18 items that cost more than the average price

-- Top 5 products 
SELECT item_name, MAX(price) top_prices
FROM restaurant.menu_items
GROUP BY item_name
ORDER BY top_prices DESC
LIMIT 5;

9.
-- Show items that cost more than the average price
SELECT item_name, price
FROM restaurant.menu_items
WHERE price > 
(SELECT ROUND(AVG(price),2)
FROM restaurant.menu_items);

10.
-- Count of orders per day
SELECT od.order_date, COUNT(*) AS total_orders
FROM restaurant.order_details od
JOIN restaurant.menu_items mi
ON mi.menu_item_id = od.menu_item_id
GROUP BY order_date;
-- A. The count is 32 orders 

11.
-- Q. Which item is the most expensive product?
SELECT item_name, price
FROM restaurant.menu_items
ORDER BY price DESC
LIMIT 1;
-- A. Shrimp Scampi is the most expensive item
12.
SELECT item_name, category, od.order_date
FROM restaurant.menu_items mi
JOIN restaurant.order_details od
ON od.menu_item_id = mi.menu_item_id    

13.
-- Q. Find the following, Avarage Price, Minimum Price, and the Maximum Price
SELECT item_name, category, price, 
AVG(price) OVER() as avg_price,
MIN(price) OVER() as min_price,
MAX(price) OVER() as max_price
FROM restaurant.menu_items;

14.
-- Q. Average Price per category / using GROUP BY and Window Function (Partition By)
SELECT category, ROUND(AVG(price),2) as category_avg_price
FROM restaurant.menu_items
GROUP BY category;
15.
SELECT category, 
AVG(price) OVER(PARTITION BY category) as category_avg_price
FROM restaurant.menu_items;

16.
-- Show items that cost higher than the average price
SELECT item_name, price FROM restaurant.menu_items
WHERE price > 
(SELECT ROUND (AVG(price),2) as Avg_Price
FROM restaurant.menu_items)

17.
-- Q. Find each item's rank within its category according to the price
SELECT item_name, category, price,
RANK() OVER(PARTITION BY category ORDER BY price DESC) Category_rank,
DENSE_RANK() OVER(PARTITION BY category ORDER BY price DESC) Category_DenseRank
FROM restaurant.menu_items;

-- A. Cheeseburger is the most expensive item within the American category and french fries alongside Mac&Cheese cost less compared to other items. 
--    Korean beef bowl and Pork Ramen both cost more in the Asian category.
--    Shrimp Scampi is the most expensive item in the Italian category and Steak Burrito costs more than any other item in the Mexican category.










