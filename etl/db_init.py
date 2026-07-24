import os
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
import logging

logger = logging.getLogger(__name__)

load_dotenv()

DB_SERVER = os.getenv("DB_SERVER")
DATABASE_NAME = os.getenv("DB_NAME")
DB_DRIVER = os.getenv("DB_DRIVER")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")

SQL_FILES = [
    "sql/create_tables.sql",
    "sql/constraints.sql",
    "sql/indexes.sql"
]


def get_master_engine():
    connection_string = (
        f"mssql+pyodbc://{DB_USER}:{DB_PASSWORD}@{DB_SERVER}/master"
        f"?driver={DB_DRIVER.replace(' ', '+')}"
        "&TrustServerCertificate=yes"
    )
    master_engine = create_engine(
        connection_string,
        future=True
    )
    return master_engine

def create_database(master_engine):
    with master_engine.connect().execution_options(isolation_level="AUTOCOMMIT") as conn:
        logger.info(
                    f"Ensuring database %s exists...",
                    DATABASE_NAME
                )
        conn.execute(text(
            f"""IF DB_ID('{DATABASE_NAME}') IS NULL
                BEGIN
                    CREATE DATABASE [{DATABASE_NAME}];
                END;"""
        ))
        logger.info("Database '%s' exists or was created successfully.", DATABASE_NAME)

def get_database_engine():
    connection_string = (
        f"mssql+pyodbc://{DB_USER}:{DB_PASSWORD}@{DB_SERVER}/{DATABASE_NAME}"
        f"?driver={DB_DRIVER.replace(' ', '+')}"
        "&TrustServerCertificate=yes"
    )
    engine = create_engine(
        connection_string,
        future=True
    )
    return engine

def execute_sql_file(db_engine):
    # Track the running file to isolate errors accurately
    current_file = None

    logger.info("Initializing automated SQL Server schema deployment pipeline...")

    try:
        with db_engine.begin() as connection:
            for sql_file in SQL_FILES:
                current_file = sql_file
                
                if not os.path.exists(sql_file):
                    raise FileNotFoundError(f"Required schema file not found on disk: {sql_file}")
                    
                logger.info(f"Processing database file: {sql_file}")
                
                with open(sql_file, "r", encoding="utf-8") as file:
                    raw_sql = file.read()
                    
                connection.execute(text(raw_sql))
                logger.info(f"Successfully applied schema updates from: {sql_file}")
                
        logger.info("Database initialization completed successfully. All schemas up to date.")

    except Exception:
        logger.critical(
            f"DEPLOYMENT ABORTED | Failure occurred in file: {current_file} | "
            "SQL Server rolled back all session changes to maintain database integrity.",
            exc_info=True
        )
        raise

def initialize_database():

    required = [DB_SERVER, DATABASE_NAME, DB_DRIVER, DB_USER, DB_PASSWORD]
    
    if not all(required):
        raise ValueError(
            "Missing one or more required database environment variables."
        )

    master_engine = get_master_engine()

    create_database(master_engine)

    db_engine = get_database_engine()

    execute_sql_file(db_engine)

    db_engine.dispose()
    master_engine.dispose()