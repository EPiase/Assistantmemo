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


@app.get("/", response_class=HTMLResponse)
async def root():
    res = open("landing_page.html")
    return res.read()


@app.get("/download_recording", response_class=StreamingResponse)
async def download_recording(sblob: str):
    from google.cloud import storage
    import io

    storage_client = storage.Client()
    # get bucket with name
    bucket = storage_client.get_bucket('fire-assistantmemo-recordings')
    # get bucket data as blob
    blob = bucket.get_blob(sblob)

    return StreamingResponse(
        io.BytesIO(blob.download_as_bytes()), media_type="audio/flac"
    )
