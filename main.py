import logging

from etl import (
    extract_products,
    extract_users,
    extract_carts,
    transform_products,
    transform_users,
    transform_carts,
    transform_cart_items,
    get_engine,
    load_dataframe
)

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

logger = logging.getLogger(__name__)


def main():

    engine = get_engine()

    try:

        logger.info("Starting ETL pipeline...")

        # Extract
        users_raw = extract_users()
        products_raw = extract_products()
        carts_raw = extract_carts()

        logger.info(
            "Extracted %d users, %d products, %d carts.",
            len(users_raw),
            len(products_raw),
            len(carts_raw),
        )

        # Transform
        users = transform_users(users_raw)
        products = transform_products(products_raw)
        carts = transform_carts(carts_raw)
        cart_items = transform_cart_items(carts_raw)

        logger.info("Starting data load.")

        # Load
        load_dataframe(users, "users", engine)
        load_dataframe(products, "products", engine)
        load_dataframe(carts, "carts", engine)
        load_dataframe(cart_items, "cart_items", engine)

        logger.info("ETL pipeline completed successfully.")
    
    except Exception:
        logger.exception("ETL pipeline failed.")
        raise
    
    finally:
        engine.dispose()

if __name__ == "__main__":
    main()