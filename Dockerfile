# Build stage
FROM python:3.12-slim-bookworm AS build

WORKDIR /build
COPY Main_Folder/main.py ./main.py

# Runtime stage
FROM python:3.12-slim-bookworm AS runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN groupadd --system --gid 10001 app && \
    useradd --system --uid 10001 --gid 10001 --no-create-home app

WORKDIR /app
COPY --from=build --chown=10001:10001 /build/main.py ./main.py

USER 10001:10001
EXPOSE 8080

ENTRYPOINT ["python", "/app/main.py"]
