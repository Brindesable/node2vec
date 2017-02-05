FROM python:2.7

RUN mkdir -p /usr/node2vec
WORKDIR /usr/node2vec

COPY requirements.txt /usr/node2vec/requirements.txt
RUN pip install numpy
RUN pip install cython
RUN pip install --no-cache-dir -r requirements.txt

COPY . /usr/node2vec