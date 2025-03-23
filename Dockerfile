FROM python:3.10-slim

RUN apt-get update && \
    apt-get install -y ffmpeg git build-essential && \
    pip install --upgrade pip && \
    pip install numpy

WORKDIR /app
COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "10000"]

RUN python -c "import numpy; print('NumPy OK')"