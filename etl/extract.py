import pandas as pd
import requests
import logging

BASE_URL = 'https://fakestoreapi.com'

def extract_products():
    product_url = f'{BASE_URL}/products'
    try:
        product_response = requests.get(product_url, timeout=30)
        product_response.raise_for_status()
    except requests.exceptions.RequestException as e:
        logging.error(
            f"Failed to fetch products from {product_url}: {e}"
        )
        raise

    products = product_response.json()
    products_dataframe = pd.DataFrame(products)
    logging.info(
        f"Extracted {len(products_dataframe)} products."
    )

    return products_dataframe

def extract_users():
    user_url = f'{BASE_URL}/users'
    try:
        user_response = requests.get(user_url, timeout=30)
        user_response.raise_for_status()
    except requests.exceptions.RequestException as e:
        logging.error(
            f"Failed to fetch products from {user_url}: {e}"
        )
        raise

    users = user_response.json()
    users_dataframe = pd.DataFrame(users)
    logging.info(
        f"Extracted {len(users_dataframe)} products."
    )

    return users_dataframe

def extract_carts():
    cart_url = f'{BASE_URL}/carts'
    try:
        cart_response = requests.get(cart_url, timeout=30)
        cart_response.raise_for_status()
    except requests.exceptions.RequestException as e:
        logging.error(
            f"Failed to fetch products from {cart_url}: {e}"
        )
        raise

    carts = cart_response.json()
    carts_dataframe = pd.DataFrame(carts)
    logging.info(
        f"Extracted {len(carts_dataframe)} products."
    )

    return carts_dataframe