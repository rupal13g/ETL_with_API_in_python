/*
===========================================
Project : Fake Store ETL
Database: SQL Server
Purpose : Create tables for ETL pipeline
Author  : Rupal Gupta
===========================================
*/

IF OBJECT_ID('dbo.users', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.users (
        user_id INT NOT NULL,
        username VARCHAR(50) NOT NULL,
        first_name VARCHAR(50) NOT NULL,
        last_name VARCHAR(50) NOT NULL,
        user_email VARCHAR(100) NOT NULL,
        user_password VARCHAR(20) NOT NULL,
        phone_number VARCHAR(20) NULL,
        street VARCHAR(200) NOT NULL,
        city VARCHAR(50) NOT NULL,
        zip_code VARCHAR(10) NOT NULL
    )
END;

IF OBJECT_ID('dbo.products', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.products (
        product_id INT NOT NULL,
        product_name VARCHAR(255) NOT NULL,
        product_price DECIMAL(10,2) NOT NULL,
        product_description VARCHAR(MAX) NULL,
        product_category VARCHAR(100) NOT NULL,
        product_image VARCHAR(MAX) NULL,
        product_rating DECIMAL(3,2) NOT NULL,
        product_rating_count INT NOT NULL
    )
END;

IF OBJECT_ID('dbo.carts', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.carts (
        cart_id INT NOT NULL,
        user_id INT NOT NULL,
        date DATE NOT NULL
    )
END;

IF OBJECT_ID('dbo.cart_items', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.cart_items (
        cart_id INT NOT NULL,
        product_id INT NOT NULL,
        quantity INT NOT NULL
    )
END;