FROM python:3.12-slim

LABEL org.opencontainers.image.source https://github.com/jdivine/heyhey

ENV PYTHONFAULTHANDLER=1 \
  PYTHONUNBUFFERED=1 \
  POETRY_NO_INTERACTION=1 

RUN pip install --upgrade pip

# The while one-liner is working around a weird non-deterministic SSL issue I was encountering locally on Ubuntu.
# it randomly failed with an SSL error but would eventually work if retried!
# Feels like a network glitch because it only happens on my home internet but IDK.
# I would never want to do this in a real-world build but don't think that isolating the issue is relevant in this example.
RUN while ( ! pip list | grep poetry ) ; do pip install poetry==2.2 ; done

WORKDIR /app

COPY . /app

RUN poetry install --no-root --no-interaction --no-ansi

EXPOSE 8080

WORKDIR /app/app

ENTRYPOINT poetry run python app.py
