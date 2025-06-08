import time
import threading

from .keys import *

cache = {}
cache_lock = threading.Lock()
CACHE_TIMEOUT = 1200  # 20 minutes

def get_cached(key):
    with cache_lock:
        entry = cache.get(key)
        if entry:
            value, timestamp = entry
            if time.time() - timestamp < CACHE_TIMEOUT:
                return value
            else:
                del cache[key]
        return None

def set_cache(key, value):
    with cache_lock:
        cache[key] = (value, time.time())

def invalidate_cache(key=None):
    with cache_lock:
        if key:
            cache.pop(key, None)
        else:
            cache.clear()
