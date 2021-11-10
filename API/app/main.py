from fastapi import FastAPI
from fastapi.responses import HTMLResponse
from fastapi import UploadFile, File, Form
# from google.api_core import retry
from routers import notes

app = FastAPI()


@app.get("/", response_class=HTMLResponse)
async def root():
    # var = {"message": "Hello API three"}
    res = open("landing_page.html")

    return res.read()
    # return var

@app.post("/uploadfile/")
async def create_upload_file(file: UploadFile = File(...)):
    from google.cloud import storage
    # import tempfile
    import aiofiles
    import uuid
    # tempfile.NamedTemporaryFile
    filename = str(uuid.uuid4())
    storage_client = storage.Client()
    bucket = storage_client.bucket("assistantmemo-recordings")
    blob = bucket.blob(file.filename)
    
    blob.upload_from_filename("sample_audio.flac")
    # f = open(f"{file_name}", "a")
    # f.write()
    async with aiofiles.open(f"{filename}{file.filename}", 'wb') as out_file:
        content = await file.read()
        await out_file.write(content)
        print(type(out_file))
        await blob.upload_from_file(out_file)

    # print(
    #     "File {} uploaded to {}.".format(
    #         file.filename, destination_blob_name
    #     )
    # )
    return {"filename": out_file.name, "destination_blob_name": destination_blob_name}



@app.post("/file/")
async def transcribe_file(speech_file: UploadFile = File(...)):
    """Transcribe the given audio file asynchronously."""
    from google.cloud import speech

    client = speech.SpeechClient()

    """
     Note that transcription is limited to a 60 seconds audio file.
     Use a GCS file for audio longer than 1 minute.
    """
    audio = speech.RecognitionAudio(content=await speech_file.read())

    config = speech.RecognitionConfig(language_code="en-US")


    operation = client.long_running_recognize(config=config, audio=audio)

    print("Waiting for operation to complete...")
    response = operation.result(timeout=90)
    print(response)
    # Each result is for a consecutive portion of the audio. Iterate through
    # them to get the transcripts for the entire audio file.
    Transcript = []

    for result in response.results:
        # The first alternative is the most likely one for this portion.
        Transcript.append(result.alternatives[0].transcript)

    return Transcript

# filename = "84-121550-0006.flac"

# @app.post("/speech-text")
# async def speech_text():
#     import speech_recognition as sr
#     # initialize the recognizer
#     r = sr.Recognizer()
#     # open the file
#     with sr.AudioFile(filename) as source:
#         # listen for the data (load audio to memory)
#         audio_data = r.record(source)
#         # recognize (convert from speech to text)
#         text = r.recognize_google(audio_data)
#         print(text)
#         return text