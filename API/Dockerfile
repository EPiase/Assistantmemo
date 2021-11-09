FROM python:3.7-slim
ENV APP_HOME /app
ENV PORT 8080
WORKDIR $APP_HOME
COPY app/ /app
COPY requirements.txt /app/requirements.txt
RUN pip3 install -U pip setuptools wheel
RUN pip3 install gunicorn uvloop httptools
RUN pip3 install -r /app/requirements.txt
CMD gunicorn --bind :$PORT --workers 1 \
    --worker-class uvicorn.workers.UvicornWorker  \
    --threads 8 main:app