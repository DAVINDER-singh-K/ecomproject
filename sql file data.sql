CREATE DATABASE EcomUttarakhand;
USE EcomUttarakhand;


CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(50),
    email VARCHAR(50),
    phone VARCHAR(15),
    city VARCHAR(50)
);
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
CREATE TABLE OrderItems (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Products (product_id, product_name, category, price) VALUES
(1, 'Laptop', 'Electronics', 50000.00),
(2, 'Smartphone', 'Electronics', 20000.00),
(3, 'Headphones', 'Accessories', 1500.00),
(4, 'Book', 'Books', 500.00),
(5, 'T-shirt', 'Clothing', 800.00);

INSERT INTO Users (user_id, user_name, email, phone, city) VALUES
(1, 'Amit', 'amit@mail.com', '1234567890', 'Dehradun'),
(2, 'Sunita', 'sunita@mail.com', '0987654321', 'Haridwar'),
(3, 'Ravi', 'ravi@mail.com', '1112223334', 'Nainital');

INSERT INTO Orders (order_id, user_id, order_date, total_amount) VALUES
(1, 1, '2023-01-10', 51500.00),
(2, 2, '2023-01-12', 20000.00),
(3, 1, '2023-02-05', 800.00),
(4, 3, '2023-02-07', 51500.00);


INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity) VALUES
(1, 1, 1, 1),
(2, 1, 3, 1),
(3, 2, 2, 1),
(4, 3, 5, 1),
(5, 4, 1, 1),
(6, 4, 4, 10);

SELECT product_name, SUM(OrderItems.quantity * Products.price) AS total_revenue
FROM OrderItems
JOIN Products ON OrderItems.product_id = Products.product_id
GROUP BY product_name;

SELECT product_name, SUM(quantity) AS total_quantity
FROM OrderItems
JOIN Products ON OrderItems.product_id = Products.product_id
GROUP BY product_name
ORDER BY total_quantity DESC
LIMIT 5;

SELECT category, SUM(OrderItems.quantity * Products.price) AS total_sales
FROM OrderItems
JOIN Products ON OrderItems.product_id = Products.product_id
GROUP BY category;

SELECT city, SUM(total_amount) AS total_revenue
FROM Orders
JOIN Users ON Orders.user_id = Users.user_id
GROUP BY city;

SELECT order_date, product_name, quantity, (quantity * price) AS total_amount
FROM OrderItems
JOIN Orders ON OrderItems.order_id = Orders.order_id
JOIN Products ON OrderItems.product_id = Products.product_id
WHERE Orders.user_id = 1;  -- Replace with the actual user ID

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(total_amount) AS total_revenue
FROM Orders
GROUP BY month
ORDER BY month;


SELECT user_name, SUM(total_amount) AS total_spend
FROM Orders
JOIN Users ON Orders.user_id = Users.user_id
GROUP BY user_name 
ORDER BY total_spend DESC
LIMIT 10;


SELECT AVG(total_amount) AS average_order_value
FROM Orders;






