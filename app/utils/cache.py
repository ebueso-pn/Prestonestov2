import functools

from app.core.cache import get_cached, set_cache, CACHE_TIMEOUT

def cache_response(cache_key_func, expire=CACHE_TIMEOUT):
    def decorator(func):
        @functools.wraps(func)
        async def wrapper(*args, **kwargs):
            cache_key = cache_key_func(*args, **kwargs)
            cached = get_cached(cache_key)
            if cached is not None:
                return cached
            result = await func(*args, **kwargs)
            set_cache(cache_key, result)
            return result
        return wrapper
    return decorator
