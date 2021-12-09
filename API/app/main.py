from fastapi import FastAPI
from fastapi import responses
from fastapi.responses import HTMLResponse
from fastapi import UploadFile, File, Form
from fastapi.responses import FileResponse
from starlette.responses import StreamingResponse

# from google.api_core import retry
from routers import notes

app = FastAPI()
app.include_router(notes.router)
