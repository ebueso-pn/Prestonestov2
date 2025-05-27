# FastAPI Project

A modern FastAPI-based web API with a structured project layout, ready for development.

## Features

- FastAPI framework with all its features
- Structured project layout for scalability
- Supabase integration for authentication and user management
- Database integration with SQLAlchemy and PostgreSQL
- Sample API endpoints with CRUD operations
- Configuration management with environment variables
- CORS middleware configuration
- Error handling
- Type annotations throughout the codebase

## Installation

1. Clone the repository
2. Create a virtual environment:
   ```
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```
3. Install dependencies:
   ```
   pip install -r requirements.txt
   ```
4. Configure environment variables:
   - Copy `.env` file to a local version if needed
   - Update database credentials and other settings

## Running the Application

Start the application with:

```
python run.py
```

This will start the server at http://localhost:8000

API Documentation is available at:
- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

## Project Structure

```
app/
├── api/
│   ├── endpoints/
│   │   ├── auth.py          # Authentication endpoints using Supabase
│   │   └── items.py         # Items CRUD endpoints
│   └── api.py               # API router
├── core/
│   ├── auth.py              # Authentication utilities and middleware
│   ├── config.py            # Application settings
│   └── supabase.py          # Supabase client configuration
├── db/
│   ├── base.py              # SQLAlchemy setup
│   └── models/              # Database models
│       └── user.py          # User profile model
├── schemas/
│   ├── auth.py              # Authentication schemas
│   └── user.py              # User schemas
└── main.py                  # FastAPI application
```

## API Endpoints

The following API endpoints are available:

### Health Check
- `GET /` - Health check endpoint

### Authentication
- `POST /api/v1/auth/register` - Register a new user
- `POST /api/v1/auth/login` - Login and get access token
- `POST /api/v1/auth/refresh` - Refresh access token
- `POST /api/v1/auth/forgot-password` - Request password reset
- `POST /api/v1/auth/reset-password` - Reset password
- `POST /api/v1/auth/logout` - Logout user
- `GET /api/v1/auth/me` - Get current user info

### Items
- `GET /api/v1/items` - List all items
- `GET /api/v1/items/{item_id}` - Get a specific item
- `POST /api/v1/items` - Create a new item
- `PUT /api/v1/items/{item_id}` - Update an existing item
- `DELETE /api/v1/items/{item_id}` - Delete an item

## Development

### Adding New Endpoints

1. Create a new file in the `app/api/endpoints/` directory
2. Define your router and endpoints
3. Import and include your router in `app/api/api.py`

### Environment Variables

Configuration is handled through environment variables and the `.env` file. See `.env` for examples.

Key environment variables include:
- `SUPABASE_URL`: Your Supabase project URL
- `SUPABASE_KEY`: Your Supabase anon/service key
- `SUPABASE_JWT_SECRET`: Your Supabase JWT secret for token validation
- `POSTGRES_*`: Database connection settings

## Supabase Integration

This project uses Supabase for:

1. **Authentication** - Email/password authentication with JWT tokens
2. **User Management** - Storing core user data
3. **Database Integration** - PostgreSQL database with foreign key relationships to Supabase Auth

The integration works as follows:
- User registration and authentication happen through Supabase Auth
- User profile data extends the Supabase user data in our application database
- The `supabase_uid` field in our database links to Supabase Auth users

## License

MIT