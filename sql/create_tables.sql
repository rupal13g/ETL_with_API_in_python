CREATE DATABASE FakeStoreDB;

USE FakeStoreDB;

CREATE TABLE users (
    user_id INT NOT NULL,
    email VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    phone VARCHAR(30) NULL
);

CREATE TABLE products (
    product_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(100) NOT NULL,
    description VARCHAR(MAX) NULL,
    image VARCHAR(MAX) NULL,
    rating_rate FLOAT NOT NULL,
    rating_count INT NOT NULL
);

CREATE TABLE carts (
    cart_id INT NOT NULL,
    user_id INT NOT NULL,
    date DATE NOT NULL
);

CREATE TABLE cart_items (
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL
);