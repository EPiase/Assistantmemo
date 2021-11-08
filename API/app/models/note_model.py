from datetime import datetime
from typing import Optional
from pydantic import BaseModel

class NoteModel(BaseModel):
    note_id: int
    audio_id: Optional [int]
    transcript: Optional [str]
    creation_date: datetime