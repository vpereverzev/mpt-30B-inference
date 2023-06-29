# Используйте образ базового Python
# FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04
FROM python:3.10-slim

# Установка зависимостей
WORKDIR /app

# Проверка версии Python и pip
RUN python3 --version && pip --version

COPY . /app

# Используем python3 для установки зависимостей
RUN python3 -m pip install --no-cache-dir -r requirements.txt
