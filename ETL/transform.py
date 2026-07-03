import pandas as pd

def transform_products(product_dataframe):
    product_df = product_dataframe.copy()

    product_df = product_df.rename(columns={
        'id'  : 'product_id',
        'title' : 'product_name',
        'price' : 'product_price',
        'description' : 'product_description',
        'category' : 'product_category',
        'image' : 'product_image'
    })

    product_df = product_df[[
        'product_id', 'product_name', 'product_price', 'product_description', 'product_category', 'product_image'
    ]]

    product_df['product_price'] = product_df['product_price'].astype(float)

    return product_df

def transform_users(user_dataframe):
    user_df = user_dataframe.copy()

    user_df['first_name'] = user_df['name'].apply(lambda x: x['firstname'])
    user_df['last_name'] = user_df['name'].apply(lambda x: x['lastname'])

    user_df['street'] = user_df['address'].apply(lambda x: x['street'])
    user_df['city'] = user_df['address'].apply(lambda x: x['city'])
    user_df['zip_code'] = user_df['address'].apply(lambda x: x['zipcode'])

    user_df = user_df.rename(columns={
        'id'  : 'user_id',
        'email' : 'user_email',
        'username' : 'username',
        'password' : 'user_password'
    })

    user_df = user_df[[
        'user_id', 'username', 'first_name', 'last_name', 'user_email', 'user_password', 'street', 'city', 'zip_code'
    ]]

    return user_df

def transform_carts(cart_dataframe):
    carts_df = cart_dataframe.rename(columns={
        "id": "cart_id",
        "userId": "user_id"
    })

    carts_df["date"] = pd.to_datetime(carts_df["date"])

    carts_df = carts_df[["cart_id", "user_id", "date"]]

    return carts_df

def transform_cart_items(cart_dataframe):
    items = (
        cart_dataframe.rename(columns={"id": "cart_id"})
          [["cart_id", "products"]]
          .explode("products")
    )

    products = pd.json_normalize(items["products"])

    items = pd.concat(
        [items.drop(columns="products").reset_index(drop=True),
         products],
        axis=1
    )

    return items.rename(columns={"productId": "product_id"})