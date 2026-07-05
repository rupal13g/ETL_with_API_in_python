/* USERS */

CREATE INDEX IX_Users_Email
ON users(email);

CREATE INDEX IX_Users_Username
ON users(username);


/* PRODUCTS */

CREATE INDEX IX_Products_Category
ON products(category);

CREATE INDEX IX_Products_Title
ON products(title);

CREATE INDEX IX_Products_Price
ON products(price);


/* CARTS */

CREATE INDEX IX_Carts_User
ON carts(user_id);

CREATE INDEX IX_Carts_Date
ON carts(date);


/* CART ITEMS */

CREATE INDEX IX_CartItems_Product
ON cart_items(product_id);

CREATE INDEX IX_CartItems_Quantity
ON cart_items(quantity);