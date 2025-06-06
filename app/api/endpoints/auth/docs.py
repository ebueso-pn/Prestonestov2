register_description_docs = """
Register a new user using Supabase Auth integration.

This endpoint performs the following steps:
1. Checks if a user already exists in the local database by email or DNI (ID number).
2. Validates that the user does not already exist to prevent duplicate registrations.
3. If the user does not exist, creates a new user in Supabase Auth with the provided email, password, phone number, and identification details.
4. Stores the new user in the local database, associating it with the Supabase user ID.
5. Generates and returns a pair of JWT authentication tokens (access and refresh tokens) for the newly registered user.

If registration fails at any step, an appropriate error message is returned.
"""

register_summary_docs = """
Register a new user with email, password, and identification details.
"""

login_description_docs = """
Authenticate an existing user using Supabase Auth integration.

This endpoint performs the following steps:
1. Checks if a user exists in the local database by email.
2. Validates the provided password against the stored credentials.
3. If authentication is successful, generates and returns a pair of JWT authentication tokens (access and refresh tokens) for the user.
4. Returns user identification details and authentication tokens.

If authentication fails at any step, an appropriate error message is returned.
"""

login_summary_docs = """
Authenticate a user and return JWT authentication tokens.
"""
