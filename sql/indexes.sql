/*
===========================================
Project : Fake Store ETL
Database: SQL Server
Purpose : Add Indexes for FakeStoreDB
Author  : Rupal Gupta
===========================================
*/

/* PRODUCTS */

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_products_category'
      AND object_id = OBJECT_ID('dbo.products')
)
BEGIN
	CREATE INDEX IX_products_category
	ON dbo.products(product_category)
END;

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_products_name'
      AND object_id = OBJECT_ID('dbo.products')
)
BEGIN
	CREATE INDEX IX_products_name
	ON dbo.products(product_name)
END;

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_products_price'
      AND object_id = OBJECT_ID('dbo.products')
)
BEGIN
	CREATE INDEX IX_products_price
	ON dbo.products(product_price)
END;


/* CARTS */

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_carts_user_id'
      AND object_id = OBJECT_ID('dbo.carts')
)
BEGIN
	CREATE INDEX IX_carts_user_id
	ON dbo.carts(user_id)
END;

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_carts_date'
      AND object_id = OBJECT_ID('dbo.carts')
)
BEGIN
	CREATE INDEX IX_carts_date
	ON dbo.carts(date)
END;


/* CART ITEMS */

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_cart_items_product'
      AND object_id = OBJECT_ID('dbo.cart_items')
)
BEGIN
	CREATE INDEX IX_cart_items_product
	ON dbo.cart_items(product_id)
END;