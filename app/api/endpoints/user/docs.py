create_user_financials_summary = """
Submit initial financial information for the authenticated user.
"""

create_user_financials_description = """
Submit the user's financial information (such as income and related details) for the first time.

This endpoint performs the following steps:
1. Checks if financial information has already been submitted for the authenticated user.
2. If financial information already exists, returns a 409 Conflict error to prevent duplicate submissions.
3. If not, creates a new financial record associated with the user.
4. Returns a success response with the newly created financial information.

If an error occurs during the process, an appropriate error message is returned.
"""
