import uvicorn
import asyncio
import sys
from pathlib import Path
from app.db.cmd import create_db_and_tables

if __name__ == "__main__":
    sys.path.insert(0, str(Path(__file__).resolve().parent))

    run = asyncio.run(create_db_and_tables())

    uvicorn.run(
        "app.main:app",
        host="0.0.0.0",
        port=5000,
        reload=True,
        log_level="info",
        workers=1
    )
