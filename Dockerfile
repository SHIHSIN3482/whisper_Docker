FROM python:3.10-slim

RUN apt-get update && \
    apt-get install -y ffmpeg git && \
    pip install --upgrade pip

WORKDIR /app
COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "10000"]
