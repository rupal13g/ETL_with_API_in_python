/* PRIMARY KEYS */

ALTER TABLE users
ADD CONSTRAINT PK_Users
PRIMARY KEY (user_id);

ALTER TABLE products
ADD CONSTRAINT PK_Products
PRIMARY KEY (product_id);

ALTER TABLE carts
ADD CONSTRAINT PK_Carts
PRIMARY KEY (cart_id);

ALTER TABLE cart_items
ADD CONSTRAINT PK_CartItems
PRIMARY KEY (cart_id, product_id);


/* FOREIGN KEYS */

ALTER TABLE carts
ADD CONSTRAINT FK_Carts_Users
FOREIGN KEY (user_id)
REFERENCES users(user_id);

ALTER TABLE cart_items
ADD CONSTRAINT FK_CartItems_Carts
FOREIGN KEY (cart_id)
REFERENCES carts(cart_id);

ALTER TABLE cart_items
ADD CONSTRAINT FK_CartItems_Products
FOREIGN KEY (product_id)
REFERENCES products(product_id);


/* UNIQUE CONSTRAINTS */

ALTER TABLE users
ADD CONSTRAINT UQ_Users_Email
UNIQUE (email);

ALTER TABLE users
ADD CONSTRAINT UQ_Users_Username
UNIQUE (username);


/* CHECK CONSTRAINTS */

ALTER TABLE products
ADD CONSTRAINT CK_Product_Price
CHECK (price >= 0);

ALTER TABLE products
ADD CONSTRAINT CK_Product_Rating
CHECK (rating_rate >= 0 AND rating_rate <= 5);

ALTER TABLE products
ADD CONSTRAINT CK_Product_RatingCount
CHECK (rating_count >= 0);

ALTER TABLE cart_items
ADD CONSTRAINT CK_CartItem_Quantity
CHECK (quantity > 0);


/* DEFAULT CONSTRAINTS */

ALTER TABLE cart_items
ADD CONSTRAINT DF_CartItem_Quantity
DEFAULT 1 FOR quantity;

ALTER TABLE carts
ADD CONSTRAINT DF_Cart_Date
DEFAULT GETDATE() FOR date;