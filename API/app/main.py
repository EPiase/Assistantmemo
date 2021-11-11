from fastapi import FastAPI
from fastapi import responses
from fastapi.responses import HTMLResponse
from fastapi import UploadFile, File, Form
from fastapi.responses import FileResponse

# from google.api_core import retry
from routers import notes

app = FastAPI()


@app.get("/", response_class=HTMLResponse)
async def root():
    # var = {"message": "Hello API three"}
    res = open("landing_page.html")

    return res.read()
    # return var


@app.put("/create-note/")
async def create_note(user_id: str, file: UploadFile = File(...)):
    from google.cloud import storage
    from google.cloud import firestore
    from google.cloud import speech
    from google.cloud import language_v1
    import tempfile
    import uuid
    import datetime

    # create file names
    audio_filename = str(uuid.uuid4()) + file.filename
    note_id = str(uuid.uuid4())

    # access GCS
    storage_client = storage.Client()
    bucket = storage_client.bucket("assistantmemo-recordings")
    blob = bucket.blob(audio_filename)

    # upload incoming audio file
    with tempfile.NamedTemporaryFile() as named_temp_file:
        named_temp_file.write(await file.read())
        blob.upload_from_filename(named_temp_file.name)
        # return {"audio_filename": audio_filename, "local_temp_name": named_temp_file.name}

    # access speech to text api
    client = speech.SpeechClient()
    gcs_uri = f"gs://assistantmemo-recordings/{audio_filename}"
    audio = speech.RecognitionAudio(uri=gcs_uri)
    config = speech.RecognitionConfig(language_code="en-US")
    operation = client.long_running_recognize(config=config, audio=audio)
    response = operation.result(timeout=90)
    Transcript = []
    for result in response.results:
        # The first alternative is the most likely one for this portion.
        Transcript.append(result.alternatives[0].transcript)
    Transcript = " ".join(Transcript)

    if len(Transcript.split()) > 20:

        # classify text
        client = language_v1.LanguageServiceClient()
        type_ = language_v1.Document.Type.PLAIN_TEXT
        document = {"content": Transcript, "type_": type_}
        response = client.classify_text(request={"document": document})
        classification = str(" ".join([cat.name for cat in response.categories]))
    else:
        classification = ""

    # access firestore
    db = firestore.Client()
    # access and set note in database
    doc_ref = (
        db.collection("users").document(user_id).collection("notes").document(note_id)
    )
    doc_ref.set(
        {
            "audio_filename": audio_filename,
            "classification": classification,
            "date_recorded": datetime.datetime.utcnow(),
            "is_starred": False,
            "text_transcript": Transcript,
        }
    )


@app.put("/star-note")
async def star_note_by_id(note_id: str, user_id: str, star_status: bool):
    from google.cloud import firestore

    db = firestore.Client()
    doc_ref = (
        db.collection("users").document(user_id).collection("notes").document(note_id)
    )
    doc_ref.update({"is_starred": star_status})


@app.delete("/delete-note")
async def delete_note_by_id(note_id: str, user_id: str):
    from google.cloud import firestore

    db = firestore.Client()
    try:
        await db.collection("users").document(user_id).collection("notes").document(
            note_id
        ).delete()
        return {"delete status": "success"}
    except:
        return {"delete status": "failed"}


@app.get("/list-notes")
async def list_all_note(user_id: str):
    from google.cloud import firestore

    db = firestore.Client()
    notes_ref = db.collection("users").document(user_id).collection("notes")
    list_of_notes = {}
    for note in notes_ref.stream():
        list_of_notes[note.id] = note.to_dict()
    return list_of_notes


@app.get("/download_file")
async def download_file(bucket: str, sblob: str):
    from google.cloud import storage
    from starlette.responses import StreamingResponse
    import io

    storage_client = storage.Client()
    # get bucket with name
    bucket = storage_client.get_bucket(bucket)
    # get bucket data as blob
    blob = bucket.get_blob(sblob)

    return StreamingResponse(
        io.BytesIO(blob.download_as_bytes()), media_type="audio/flac"
    )
