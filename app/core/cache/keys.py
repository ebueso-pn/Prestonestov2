def get_user_cache_info_key(user, **kwargs):
    print(user)
    return f"user_full_info:{user.id}"
