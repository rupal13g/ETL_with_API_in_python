import os
from dotenv import load_dotenv
from sqlalchemy import create_engine
import logging

logger = logging.getLogger(__name__)

load_dotenv()


def get_engine():
    server = os.getenv("DB_SERVER")
    database = os.getenv("DB_DATABASE")
    driver = os.getenv("DB_DRIVER")

    connection_string = (
        f"mssql+pyodbc://@{server}/{database}"
        f"?driver={driver.replace(' ', '+')}"
        "&trusted_connection=yes"
    )

    engine = create_engine(connection_string)

    return engine

def load_dataframe(df, table_name):
    engine = get_engine()

    if df.empty:
        logger.warning("%s is empty. Nothing to load.", table_name)
        return

    try:
        df.to_sql(
            name=table_name,
            con=engine,
            if_exists="append",
            index=False,
            chunksize=1000
        )

        logger.info(
        "Loaded %d rows into %s",
        len(df),
        table_name
        )

    except Exception as e:
        logger.exception(
            "Failed to load data into %s",
            table_name
        )
        raise