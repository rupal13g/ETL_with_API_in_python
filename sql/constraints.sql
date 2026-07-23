/*
===========================================
Project : Fake Store ETL
Database: SQL Server
Purpose : Add Constraints for FakeStoreDB
Author  : Rupal Gupta
===========================================
*/

/* PRIMARY KEYS */
IF OBJECT_ID('PK_users', 'PK') IS NULL 
BEGIN
	ALTER TABLE dbo.users
	ADD CONSTRAINT PK_users
	PRIMARY KEY (user_id)
END;

IF OBJECT_ID('PK_products', 'PK') IS NULL 
BEGIN
	ALTER TABLE dbo.products
	ADD CONSTRAINT PK_products
	PRIMARY KEY (product_id)
END;

IF OBJECT_ID('PK_carts', 'PK') IS NULL 
BEGIN
	ALTER TABLE dbo.carts
	ADD CONSTRAINT PK_carts
	PRIMARY KEY (cart_id)
END;

IF OBJECT_ID('PK_cart_items', 'PK') IS NULL 
BEGIN
	ALTER TABLE dbo.cart_items
	ADD CONSTRAINT PK_cart_items
	PRIMARY KEY (cart_id, product_id)
END;


/* FOREIGN KEYS */

IF OBJECT_ID('FK_carts_users', 'F') IS NULL 
BEGIN
	ALTER TABLE dbo.carts
	ADD CONSTRAINT FK_carts_users
	FOREIGN KEY (user_id)
	REFERENCES dbo.users(user_id)
END;

IF OBJECT_ID('FK_cart_items_carts', 'F') IS NULL 
BEGIN
	ALTER TABLE dbo.cart_items
	ADD CONSTRAINT FK_cart_items_carts
	FOREIGN KEY (cart_id)
	REFERENCES dbo.carts(cart_id)
END;

IF OBJECT_ID('FK_cart_items_products', 'F') IS NULL 
BEGIN
	ALTER TABLE dbo.cart_items
	ADD CONSTRAINT FK_cart_items_products
	FOREIGN KEY (product_id)
	REFERENCES dbo.products(product_id)
END;


/* UNIQUE CONSTRAINTS */

IF OBJECT_ID('UQ_users_email', 'UQ') IS NULL 
BEGIN
	ALTER TABLE dbo.users
	ADD CONSTRAINT UQ_users_email
	UNIQUE (user_email)
END;

IF OBJECT_ID('UQ_users_username', 'UQ') IS NULL 
BEGIN
	ALTER TABLE dbo.users
	ADD CONSTRAINT UQ_users_username
	UNIQUE (username)
END;


/* CHECK CONSTRAINTS */

IF OBJECT_ID('CK_product_price', 'C') IS NULL 
BEGIN
	ALTER TABLE dbo.products
	ADD CONSTRAINT CK_product_price
	CHECK (product_price >= 0)
END;

IF OBJECT_ID('CK_product_rating', 'C') IS NULL 
BEGIN
	ALTER TABLE dbo.products
	ADD CONSTRAINT CK_product_rating
	CHECK (product_rating >= 0 AND product_rating <= 5)
END;

IF OBJECT_ID('CK_product_rating_count', 'C') IS NULL 
BEGIN
	ALTER TABLE dbo.products
	ADD CONSTRAINT CK_product_rating_count
	CHECK (product_rating_count >= 0)
END;

IF OBJECT_ID('CK_cart_item_quantity', 'C') IS NULL 
BEGIN
	ALTER TABLE dbo.cart_items
	ADD CONSTRAINT CK_cart_item_quantity
	CHECK (quantity > 0)
END;


/* DEFAULT CONSTRAINTS */

IF OBJECT_ID('DF_cart_item_quantity', 'D') IS NULL 
BEGIN
	ALTER TABLE dbo.cart_items
	ADD CONSTRAINT DF_cart_item_quantity
	DEFAULT 1 FOR quantity
END;

IF OBJECT_ID('DF_cart_date', 'D') IS NULL 
BEGIN
	ALTER TABLE dbo.carts
	ADD CONSTRAINT DF_cart_date
	DEFAULT GETDATE() FOR date
END;