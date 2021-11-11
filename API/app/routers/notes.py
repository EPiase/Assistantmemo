from fastapi import APIRouter
from fastapi.responses import HTMLResponse
from fastapi import UploadFile, File, Form
from google.api_core import retry
from models.note_model import NoteModel
from datetime import datetime

router = APIRouter()


@router.get("/get_note_by_id")
async def get_note_by_id():
    """TODO Check to see if the note exists after completing sql alchemy component"""
    note = NoteModel(
        note_id=1, transcript="this is a temp fake note", creation_date=datetime.now()
    )
    return "note"


"""
get (x) notes after clause
	How many?
	sorted how? (id, date)
	date or id in question

post note (create note w/ audio)
	send audio file
	return id

DELETE note by id
	return status
"""
