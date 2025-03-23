from fastapi import FastAPI, UploadFile, File
from pydantic import BaseModel
import whisper
import aiohttp
import tempfile
import os

app = FastAPI()
model = whisper.load_model("tiny")

class AudioURL(BaseModel):
    url: str

@app.post("/transcribe_url")
async def transcribe_from_url(data: AudioURL):
    async with aiohttp.ClientSession() as session:
        async with session.get(data.url) as resp:
            if resp.status != 200:
                return {"error": "Failed to download audio file"}
            suffix = os.path.splitext(data.url)[-1]
            with tempfile.NamedTemporaryFile(delete=False, suffix=suffix) as tmp:
                tmp.write(await resp.read())
                tmp_path = tmp.name
    result = model.transcribe(tmp_path)
    os.remove(tmp_path)
    return {"text": result["text"]}

@app.post("/transcribe_file")
async def transcribe_from_file(file: UploadFile = File(...)):
    with tempfile.NamedTemporaryFile(delete=False, suffix=".m4a") as tmp:
        tmp.write(await file.read())
        tmp_path = tmp.name
    result = model.transcribe(tmp_path)
    os.remove(tmp_path)
    return {"text": result["text"]}