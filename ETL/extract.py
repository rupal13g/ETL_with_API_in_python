import pandas as pd
import requests

BASE_URL = 'https://fakestoreapi.com/'

def extract_products():
    product_url = f'{BASE_URL}/products'
    product_response = requests.get(product_url)
    product_response.raise_for_status()

    product = product_response.json()
    product_dataframe = pd.DataFrame(product)

    return product_dataframe

def extract_users():
    user_url = f'{BASE_URL}/users'
    user_response = requests.get(user_url)
    user_response.raise_for_status()

    user = user_response.json()
    user_dataframe = pd.DataFrame(user)

    return user_dataframe

def extract_carts():
    cart_url = f'{BASE_URL}/carts'
    cart_response = requests.get(cart_url)
    cart_response.raise_for_status()

    cart = cart_response.json()
    cart_dataframe = pd.DataFrame(cart)

    return cart_dataframe