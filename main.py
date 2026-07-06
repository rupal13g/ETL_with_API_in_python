import logging

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

from etl import (
    extract_products,
    extract_users,
    extract_carts,
    transform_products,
    transform_users,
    transform_carts,
    transform_cart_items,
    load_dataframe
)

def main():
    # Extract
    users_raw = extract_users()
    products_raw = extract_products()
    carts_raw = extract_carts()

    # Transform
    users = transform_users(users_raw)
    products = transform_products(products_raw)
    carts = transform_carts(carts_raw)
    cart_items = transform_cart_items(carts_raw)

    # Load
    load_dataframe(users, "users")
    load_dataframe(products, "products")
    load_dataframe(carts, "carts")
    load_dataframe(cart_items, "cart_items")

if __name__ == "__main__":
    main()