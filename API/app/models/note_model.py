from datetime import datetime
from typing import Optional
from pydantic import BaseModel


class NoteModel(BaseModel):
    note_id: int
    audio_filename: Optional[str]
    text_transcript: str
    classification: Optional[str]
    is_starred: bool
    date_recorded: datetime
