CREATE DATABASE FakeStoreDB

USE FakeStoreDB

CREATE TABLE users (
    user_id INT,
    email VARCHAR(100),
    username VARCHAR(50),
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    phone VARCHAR(30)
);

CREATE TABLE products (
    product_id INT,
    title VARCHAR(255),
    price DECIMAL(10,2),
    category VARCHAR(100),
    description VARCHAR(MAX),
    image VARCHAR(MAX),
    rating_rate FLOAT,
    rating_count INT
);

CREATE TABLE carts (
    cart_id INT,
    user_id INT,
    date DATE
);

CREATE TABLE cart_items (
    cart_id INT,
    product_id INT,
    quantity INT
);