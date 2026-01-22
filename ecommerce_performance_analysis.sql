CREATE DATABASE ecommerce_retention;
USE ecommerce_retention;

-- Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(150),
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE
);

-- Categories
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

-- Products
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150),
    category_id INT,
    price DECIMAL(10,2),
    cost DECIMAL(10,2),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order Items
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    selling_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Payments
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),
    payment_status VARCHAR(30),
    payment_date DATE,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO categories VALUES
(1,'Electronics'),
(2,'Fashion'),
(3,'Home & Kitchen'),
(4,'Books'),
(5,'Beauty'),
(6,'Sports'),
(7,'Toys'),
(8,'Groceries');

INSERT INTO customers VALUES
(1,'Amit Sharma','amit@gmail.com','Delhi','Delhi','2023-11-10'),
(2,'Neha Verma','neha@gmail.com','Pune','Maharashtra','2023-11-15'),
(3,'Rahul Mehta','rahul@gmail.com','Mumbai','Maharashtra','2023-12-01'),
(4,'Sneha Patil','sneha@gmail.com','Nashik','Maharashtra','2023-12-10'),
(5,'Rohit Singh','rohit@gmail.com','Jaipur','Rajasthan','2023-12-18'),
(6,'Priya Gupta','priya@gmail.com','Delhi','Delhi','2024-01-05'),
(7,'Ankit Yadav','ankit@gmail.com','Noida','UP','2024-01-08'),
(8,'Pooja Joshi','pooja@gmail.com','Indore','MP','2024-01-12'),
(9,'Karan Malhotra','karan@gmail.com','Chandigarh','Punjab','2024-01-18'),
(10,'Simran Kaur','simran@gmail.com','Amritsar','Punjab','2024-01-22'),
(11,'Vikas Rana','vikas@gmail.com','Dehradun','Uttarakhand','2024-02-01'),
(12,'Nidhi Kapoor','nidhi@gmail.com','Delhi','Delhi','2024-02-04'),
(13,'Saurabh Jain','saurabh@gmail.com','Bhopal','MP','2024-02-08'),
(14,'Manish Kumar','manish@gmail.com','Patna','Bihar','2024-02-12'),
(15,'Ayesha Khan','ayesha@gmail.com','Lucknow','UP','2024-02-15'),
(16,'Ritu Arora','ritu@gmail.com','Gurgaon','Haryana','2024-02-18'),
(17,'Mohit Aggarwal','mohit@gmail.com','Meerut','UP','2024-02-20'),
(18,'Deepak Chauhan','deepak@gmail.com','Ajmer','Rajasthan','2024-02-22'),
(19,'Kavita Mishra','kavita@gmail.com','Varanasi','UP','2024-03-01'),
(20,'Arjun Nair','arjun@gmail.com','Kochi','Kerala','2024-03-05');

INSERT INTO products VALUES
(1,'Bluetooth Headphones',1,2999,1800),
(2,'Smart Watch',1,4999,3200),
(3,'Wireless Mouse',1,999,400),
(4,'Laptop Backpack',1,1999,1200),

(5,'Running Shoes',2,2499,1500),
(6,'Men T-Shirt',2,799,350),
(7,'Women Kurti',2,1499,700),
(8,'Jeans',2,1999,1100),

(9,'Mixer Grinder',3,3499,2600),
(10,'Nonstick Pan',3,1299,700),
(11,'Bedsheet Set',3,1599,900),

(12,'Atomic Habits',4,499,200),
(13,'Rich Dad Poor Dad',4,399,180),
(14,'Python Programming',4,699,350),

(15,'Face Wash',5,299,120),
(16,'Hair Dryer',5,1799,1100),

(17,'Cricket Bat',6,2999,2000),
(18,'Yoga Mat',6,999,450),

(19,'Kids Toy Car',7,899,400),
(20,'Board Game',7,1299,600),

(21,'Basmati Rice 5kg',8,699,550),
(22,'Olive Oil 1L',8,899,650);

INSERT INTO orders VALUES
(101,1,'2024-01-12','Delivered'),
(102,1,'2024-02-18','Delivered'),
(103,1,'2024-03-20','Delivered'),

(104,2,'2024-01-15','Delivered'),
(105,2,'2024-03-05','Delivered'),

(106,3,'2024-01-20','Delivered'),
(107,3,'2024-02-25','Delivered'),
(108,3,'2024-04-02','Delivered'),

(109,4,'2024-02-01','Delivered'),
(110,5,'2024-02-10','Delivered'),
(111,6,'2024-02-18','Delivered'),

(112,7,'2024-03-01','Delivered'),
(113,8,'2024-03-05','Delivered'),
(114,9,'2024-03-10','Delivered'),
(115,10,'2024-03-12','Delivered'),

(116,1,'2024-04-10','Delivered'),
(117,2,'2024-04-15','Delivered'),
(118,3,'2024-04-18','Delivered'),
(119,4,'2024-04-20','Delivered');

INSERT INTO order_items VALUES
(1,101,1,1,2999),
(2,101,3,1,999),

(3,102,5,1,2499),
(4,102,6,2,799),

(5,103,12,1,499),

(6,104,2,1,4999),
(7,105,14,1,699),

(8,106,9,1,3499),
(9,107,10,2,1299),
(10,108,11,1,1599),

(11,109,15,2,299),
(12,110,17,1,2999),
(13,111,18,1,999),

(14,112,21,1,699),
(15,113,22,1,899),

(16,114,7,1,1499),
(17,115,8,1,1999),

(18,116,4,1,1999),
(19,117,6,2,799),
(20,118,12,2,499),
(21,119,5,1,2499);

INSERT INTO payments VALUES
(1,101,'UPI','Success','2024-01-12'),
(2,102,'Card','Success','2024-02-18'),
(3,103,'UPI','Success','2024-03-20'),

(4,104,'NetBanking','Success','2024-01-15'),
(5,105,'UPI','Success','2024-03-05'),

(6,106,'Card','Success','2024-01-20'),
(7,107,'UPI','Success','2024-02-25'),
(8,108,'Card','Success','2024-04-02'),

(9,109,'UPI','Success','2024-02-01'),
(10,110,'UPI','Success','2024-02-10'),
(11,111,'Card','Success','2024-02-18'),

(12,112,'UPI','Success','2024-03-01'),
(13,113,'Card','Success','2024-03-05'),
(14,114,'UPI','Success','2024-03-10'),
(15,115,'UPI','Success','2024-03-12'),

(16,116,'Card','Success','2024-04-10'),
(17,117,'UPI','Success','2024-04-15'),
(18,118,'UPI','Success','2024-04-18'),
(19,119,'Card','Success','2024-04-20');




