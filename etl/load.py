import os
from dotenv import load_dotenv
from sqlalchemy import create_engine
import logging

logger = logging.getLogger(__name__)

load_dotenv()

CHUNK_SIZE = 1000


def get_engine():

    """Create and validate a SQLAlchemy engine for SQL Server."""

    server = os.getenv("DB_SERVER")
    database = os.getenv("DB_DATABASE")
    driver = os.getenv("DB_DRIVER")

    required = [server, database, driver]

    if not all(required):
        raise ValueError(
            "Missing one or more required database environment variables."
        )

    connection_string = (
        f"mssql+pyodbc://@{server}/{database}"
        f"?driver={driver.replace(' ', '+')}"
        "&trusted_connection=yes"
    )

    engine = create_engine(
        connection_string,
        future=True
    )

    with engine.connect():
        logger.info("Connected to SQL Server database: %s", database)

    return engine



def load_dataframe(df, table_name, engine):

    """Load a pandas DataFrame into a SQL Server table."""

    if df.empty:
        logger.warning("%s is empty. Nothing to load.", table_name)
        return

    try:
        df.to_sql(
            name=table_name,
            con=engine,
            if_exists="append",
            index=False,
            chunksize=CHUNK_SIZE
        )

        logger.info(
            "Loaded %d rows into %s",
            len(df),
            table_name,
        )

    except Exception:
        logger.exception(
            "Failed to load data into %s",
            table_name
        )
        raise