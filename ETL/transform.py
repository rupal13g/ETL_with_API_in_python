import pandas as pd

def transform_product(product_dataframe):
    product_df = product_dataframe.copy()

    product_df = product_df.rename(columns={
        'id'  : 'product_id',
        'title' : 'product_name',
        'price' : 'product_price',
        'description' : 'product_description',
        'category' : 'product_category',
        'image' : 'product_image'
    })

    product_df = product_df[{
        'product_id', 'product_name', 'product_price', 'product_description', 'product_category', 'product_image'
    }]

    product_df['product_price'] = product_df['product_price'].astype(float)

    return product_df

