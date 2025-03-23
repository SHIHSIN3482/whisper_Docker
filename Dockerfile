FROM python:3.10  # ❗不要用 slim

# 安裝必要依賴：ffmpeg、build tools、numpy
RUN apt-get update && \
    apt-get install -y ffmpeg git build-essential && \
    pip install --upgrade pip && \
    pip install numpy

# 設定工作目錄
WORKDIR /app
COPY . /app

# 安裝其他依賴
RUN pip install --no-cache-dir -r requirements.txt

# 執行伺服器
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "10000"]