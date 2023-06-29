# Используйте образ базового Python
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04

# Установка зависимостей
WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Nicosia

RUN apt-get update && apt-get install -y \
    make \
    curl \
    unzip \
    g++ \
    git \
    software-properties-common

# Создаем директорию /usr/local/nvidia/lib64 и добавляем в нее символическую ссылку на libcudart.so
RUN mkdir -p /usr/local/nvidia/lib64 && \
    ln -s /usr/local/cuda/lib64/libcudart.so /usr/local/nvidia/lib64/libcudart.so

# Обновление переменной LD_LIBRARY_PATH
RUN echo "LD_LIBRARY_PATH=/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}" >> /etc/environment 

# Добавление deadsnakes PPA и установка Python 3.10
RUN add-apt-repository ppa:deadsnakes/ppa -y && apt-get update && apt-get install -y python3.10 python3.10-distutils python3.10-dev python3.10-venv

# Установка pip
RUN curl https://bootstrap.pypa.io/get-pip.py | python3.10

# Обновление альтернатив Python
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

# Проверка версии Python и pip
RUN python3 --version && pip --version

COPY . /app

# Используем python3 для установки зависимостей
RUN python3 -m pip install --no-cache-dir -r requirements.txt
