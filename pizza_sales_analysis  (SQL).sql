-- 🍕 Pizza Sales Data Analysis (SQL Project)

-- 1️⃣ Retrieve the total number of orders placed
SELECT COUNT(DISTINCT order_id) AS total_orders FROM orders;

-- 2️⃣ Calculate the total revenue generated from pizza sales
SELECT SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id;

-- 3️⃣ Identify the highest-priced pizza
SELECT pizza_id, price FROM pizzas ORDER BY price DESC LIMIT 1;

-- 4️⃣ Identify the most common pizza size ordered
SELECT p.size, COUNT(*) AS order_count
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY order_count DESC
LIMIT 1;

-- 5️⃣ List the top 5 most ordered pizza types along with their quantities
SELECT pt.name, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;

-- 6️⃣ Total quantity of each pizza category ordered
SELECT pt.category, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

-- 7️⃣ Distribution of orders by hour of the day
SELECT HOUR(time) AS order_hour, COUNT(order_id) AS order_count
FROM orders
GROUP BY order_hour
ORDER BY order_hour;

-- 8️⃣ Category-wise distribution of pizzas
SELECT pt.category, COUNT(*) AS total_orders
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_orders DESC;

-- 9️⃣ Average number of pizzas ordered per day
SELECT date, ROUND(AVG(quantity), 2) AS avg_pizzas_per_day
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY date
ORDER BY date;

-- 🔟 Top 3 most ordered pizza types based on revenue
SELECT pt.name, SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue DESC
LIMIT 3;

-- 1️⃣1️⃣ Percentage contribution of each pizza type to total revenue
SELECT pt.name, 
       ROUND(SUM(od.quantity * p.price) * 100 / (SELECT SUM(od.quantity * p.price) FROM order_details od JOIN pizzas p ON od.pizza_id = p.pizza_id), 2) AS revenue_percentage
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue_percentage DESC;

-- 1️⃣2️⃣ Cumulative revenue generated over time
SELECT date, SUM(od.quantity * p.price) OVER (ORDER BY date) AS cumulative_revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
ORDER BY date;

-- 1️⃣3️⃣ Top 3 most ordered pizza types based on revenue for each category
SELECT pt.category, pt.name, SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category, pt.name
ORDER BY pt.category, total_revenue DESC;
