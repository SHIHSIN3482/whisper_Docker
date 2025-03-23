FROM python:3.10  

RUN apt-get update && \
    apt-get install -y ffmpeg git build-essential && \
    pip install --upgrade pip && \
    pip install numpy

WORKDIR /app
COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "10000"]