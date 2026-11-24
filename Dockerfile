FROM python:3.12-slim-bookworm

ENV PYTHONUNBUFFERED=1 \
    CHROME_PATH=/usr/bin/chromium \
    TS_PROFILE_DIR=/data/ts_profile \
    PORT=8191

RUN apt-get update && apt-get install -y --no-install-recommends \
        chromium \
        xvfb \
        ca-certificates \
        fonts-liberation \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir nodriver

WORKDIR /app
COPY solver.py service.py clientsend.py ./

RUN mkdir -p /data/ts_profile

EXPOSE 8191
# service.py starts Xvfb itself when DISPLAY is unset (Linux path)
CMD ["python", "service.py"]
