/*
===========================================
Project : Fake Store ETL
Database: SQL Server
Purpose : Add Indexes for FakeStoreDB
Author  : Rupal Gupta
===========================================
*/

/* PRODUCTS */

IF OBJECT_ID(N'IX_products_category', N'IX') IS NULL
BEGIN
	CREATE INDEX IX_products_category
	ON dbo.products(product_category)
END;
GO

IF OBJECT_ID(N'IX_products_name', N'IX') IS NULL
BEGIN
	CREATE INDEX IX_products_name
	ON dbo.products(product_name)
END;
GO

IF OBJECT_ID(N'IX_products_price', N'IX') IS NULL
BEGIN
	CREATE INDEX IX_products_price
	ON dbo.products(product_price)
END;
GO


/* CARTS */

IF OBJECT_ID(N'IX_carts_user', N'IX') IS NULL
BEGIN
	CREATE INDEX IX_carts_user
	ON dbo.carts(user_id)
END;
GO

IF OBJECT_ID(N'IX_carts_date', N'IX') IS NULL
BEGIN
	CREATE INDEX IX_carts_date
	ON dbo.carts(date)
END;
GO


/* CART ITEMS */

IF OBJECT_ID(N'IX_cart_items_product', N'IX') IS NULL
BEGIN
	CREATE INDEX IX_cart_items_product
	ON dbo.cart_items(product_id)
END;
GO