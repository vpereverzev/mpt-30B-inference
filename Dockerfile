# Используйте образ базового Python
FROM python:3.10-slim

# Установка зависимостей
WORKDIR /app

RUN apt-get update && apt-get install -y \
    make \
    curl \
    unzip \
    g++ \
    git \
    software-properties-common

# Проверка версии Python и pip
RUN python3 --version && pip --version

COPY requirements.txt /app/requirements.txt

# Используем python3 для установки зависимостей
RUN python3 -m pip install --no-cache-dir -r requirements.txt
