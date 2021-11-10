FROM python:3.9-slim
ENV APP_HOME /app
ENV PORT 8080
WORKDIR $APP_HOME
COPY API/app/ /app
COPY API/requirements.txt /app/requirements.txt
RUN pip3 install -U pip setuptools wheel
RUN pip3 install gunicorn uvloop httptools
RUN pip3 install -r /app/requirements.txt
CMD gunicorn main:app -c gunicorn_config.py