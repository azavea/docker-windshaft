FROM node:10-slim

MAINTAINER Azavea <systems@azavea.com>

ENV WINDSHAFT_VERSION 5.2.1

RUN mkdir -p /opt/windshaft

WORKDIR /opt/windshaft

RUN set -ex \
  && buildDeps=' \
    build-essential \
    python \
    git-core \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg62-turbo-dev \
    libgif-dev \
    libpq-dev \
    ' \
  && deps=' \
    libcairo2 \
    libgif7 \
    libjpeg62-turbo \
    libpixman-1-0 \
    ' \
  && apt-get update && apt-get install -y ${buildDeps} ${deps} --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  && npm install --unsafe-perm windshaft@${WINDSHAFT_VERSION} \
  && apt-get purge -y --auto-remove ${buildDeps}

EXPOSE 5000

ENTRYPOINT ["node"]
