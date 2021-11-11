from datetime import datetime
from typing import Optional
from pydantic import BaseModel


class NoteModel(BaseModel):
    note_id: int
    user_id: int
    audio_URL: Optional[str]
    transcript: str
    classification: Optional[str]
    is_starred: bool
    date_recorded: datetime
