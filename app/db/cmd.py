from typing import Annotated
import logging
import sys
import importlib

from fastapi import Depends, FastAPI, HTTPException, Query
from sqlalchemy import create_engine, inspect, text
from sqlalchemy.orm import sessionmaker
from app.db.base import Base, engine

logger = logging.getLogger(__name__)
# Set up console logging for better debugging
logging.basicConfig(level=logging.INFO)

async def ensure_database_exists():
    # Extract connection details from the engine URL
    url = str(engine.url)

    # Only proceed if it's PostgreSQL
    if not url.startswith('postgresql'):
        logger.warning(f"Expected PostgreSQL database, but found: {url}")
        return

    # Parse the connection URL to extract components
    user = engine.url.username
    password = engine.url.password
    host = engine.url.host
    port = engine.url.port or 5432
    db_name = engine.url.database

    try:
        import asyncpg
        # Connect to 'postgres' database (default system database)
        conn = await asyncpg.connect(
            user=user,
            password=password,
            host=host,
            port=port,
            database='postgres'  # Connect to default postgres database
        )

        # Check if our database exists
        result = await conn.fetchrow("SELECT 1 FROM pg_database WHERE datname = $1", db_name)

        if not result:
            # Create database if it doesn't exist
            await conn.execute(f"CREATE DATABASE {db_name}")
            logger.debug(f"Database '{db_name}' created successfully")
        else:
            logger.debug(f"Database '{db_name}' already exists")

        await conn.close()

    except Exception as e:
        logger.error(f"Error ensuring database exists: {str(e)}")
        raise

async def create_db_and_tables():
    # First ensure the database exists
    await ensure_database_exists()
    try:

        importlib.import_module("app.db.models")
        logger.debug(f"After imports, tables defined: {Base.metadata.tables.keys()}")
    except ImportError as e:
        logger.warning(f"Could not import model modules: {e}")

    try:
        # Then create tables
        async with engine.begin() as conn:
            # First check connection
            await conn.execute(text("SELECT 1"))
            logger.debug("Database connection successful")

            # Try to create tables
            await conn.run_sync(Base.metadata.create_all)
            logger.debug("Database tables creation attempted")

            # Verify if tables were created
            def check_tables(connection):
                inspector = inspect(connection)
                tables = inspector.get_table_names()
                logger.debug(f"Tables in database: {tables}")
                return tables

            tables = await conn.run_sync(check_tables)
            if not tables:
                logger.warning("No tables were created!")
            else:
                logger.debug("Database tables created successfully")
    except Exception as e:
        logger.error(f"Error creating tables: {str(e)}")
        raise
