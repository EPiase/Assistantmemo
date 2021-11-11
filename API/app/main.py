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

@app.post("/create-note/")
async def create_note(user_id: str, file: UploadFile = File(...)):
    from google.cloud import storage
    from google.cloud import firestore
    from google.cloud import speech
    import tempfile
    import uuid
    import datetime

    # create file names
    audio_filename = str(uuid.uuid4()) + file.filename
    note_filename = str(uuid.uuid4())
    
    # access GCS
    storage_client = storage.Client()
    bucket = storage_client.bucket("assistantmemo-recordings")
    blob = bucket.blob(audio_filename)
    
    # upload incoming audio file
    with tempfile.NamedTemporaryFile() as named_temp_file:
        named_temp_file.write(await file.read())
        blob.upload_from_filename(named_temp_file.name)
        # return {"audio_filename": audio_filename, "local_temp_name": named_temp_file.name}

    # access firestore
    db = firestore.Client()
    # access and set note in database
    doc_ref = db.collection('users').document(user_id).collection('notes').document(note_filename)
    doc_ref.set({
        'audio_filename': audio_filename,
        'classification': 'misc',
        'date_recorded': datetime.datetime.utcnow(),
        'is_starred': False,
        'text_transcript': ''
    })

    # access speech to text api
    client = speech.SpeechClient()
    gcs_uri = f'gs://assistantmemo-recordings/{audio_filename}'
    audio = speech.RecognitionAudio(uri=gcs_uri)
    config = speech.RecognitionConfig(language_code="en-US")
    operation = client.long_running_recognize(config=config, audio=audio)
    response = operation.result(timeout=90)
    Transcript = []
    for result in response.results:
        # The first alternative is the most likely one for this portion.
        Transcript.append(result.alternatives[0].transcript)
    return Transcript






@app.get("/download_file")
async def download_file(bucket: str, sblob: str):
    from google.cloud import storage
    from starlette.responses import StreamingResponse
    import io
    import tempfile

    storage_client = storage.Client()
    # get bucket with name
    bucket = storage_client.get_bucket(bucket)
    # get bucket data as blob
    blob = bucket.get_blob(sblob)

    return StreamingResponse(io.BytesIO(blob.download_as_bytes()), media_type='audio/flac')

# @app.get("/firebase")
# async def get_firebase_users():
#     from google.cloud import firestore
#     db = firestore.Client()

#     # Add a new document
#     # doc_ref = db.collection('users').document('YvVBPoGPal8VVQmCdnnd').collection('notes').document('FWsAw2vjsEl3R1HJgwy0')
#     # doc_ref.set({
#     #     'audio_url': '',
#     #     'classification': '/Computers & Electronics/Computer Hardware/Computer Components',
#     #     'date_recorded': '11/10/21, 7:44 PM',
#     #     'is_starred': False,
#     #     'text_transcript': 'I will be getting a new intel processor over the coming weeks.'
#     # })

#     # Then query for documents
#     users_ref = db.collection('users').document('YvVBPoGPal8VVQmCdnnd').collection('notes')
#     return ['{} => {}'.format(doc.id, doc.to_dict()) for doc in users_ref.stream()]

# async def transcribe_file(speech_file: UploadFile = File(...)):
#     """Transcribe the given audio file asynchronously."""
#     from google.cloud import speech

#     client = speech.SpeechClient()

#     """
#      Note that transcription is limited to a 60 seconds audio file.
#      Use a GCS file for audio longer than 1 minute.
#     """
#     audio = speech.RecognitionAudio(content=await speech_file.read())

#     config = speech.RecognitionConfig(language_code="en-US")


#     operation = client.long_running_recognize(config=config, audio=audio)

#     print("Waiting for operation to complete...")
#     response = operation.result(timeout=90)
#     print(response)
#     # Each result is for a consecutive portion of the audio. Iterate through
#     # them to get the transcripts for the entire audio file.
#     Transcript = []

#     for result in response.results:
#         # The first alternative is the most likely one for this portion.
#         Transcript.append(result.alternatives[0].transcript)

#     return Transcript