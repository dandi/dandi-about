FROM floryn90/hugo:ext-alpine

USER root

RUN apk add --no-cache git && \
  git config --global --add safe.directory /src
