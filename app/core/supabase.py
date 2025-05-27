from supabase import create_client, Client
import os
from typing import Optional
from functools import lru_cache
from app.core.config import settings

class SupabaseClient:
    """
    Singleton class to manage Supabase client instance and provide utilities
    for authentication and database operations.
    """
    _instance: Optional[Client] = None

    @classmethod
    def get_client(cls) -> Client:
        """
        Get or create a Supabase client instance.

        Returns:
            Client: Supabase client instance
        """
        if cls._instance is None:
            supabase_url = settings.SUPABASE_URL
            supabase_key = settings.SUPABASE_KEY

            if not supabase_url or not supabase_key:
                raise ValueError(
                    "Supabase URL and key must be provided. "
                    "Set SUPABASE_URL and SUPABASE_KEY environment variables."
                )

            cls._instance = create_client(supabase_url, supabase_key)

        return cls._instance

    @classmethod
    def reset_client(cls) -> None:
        """Reset the client instance, useful for testing."""
        cls._instance = None

@lru_cache()
def get_supabase() -> Client:
    """
    Get a cached Supabase client instance.

    Returns:
        Client: Supabase client instance
    """
    return SupabaseClient.get_client()

# Convenience direct accessors
def auth():
    """Get Supabase auth client."""
    return get_supabase().auth

def table(table_name: str):
    """
    Get a Supabase table query builder.

    Args:
        table_name (str): Name of the table to query

    Returns:
        PostgrestQueryBuilder: A query builder for the specified table
    """
    return get_supabase().table(table_name)

def storage():
    """Get Supabase storage client."""
    return get_supabase().storage

def rpc(fn_name, params=None):
    """
    Call a Postgres function via RPC.

    Args:
        fn_name (str): Name of the function to call
        params (dict, optional): Parameters to pass to the function

    Returns:
        Any: Result of the RPC call
    """
    return get_supabase().rpc(fn_name, params)
