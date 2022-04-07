FROM elixir:alpine as build

WORKDIR /app

RUN apk add --no-cache build-base npm git python3

RUN mix local.hex --force && \
    mix local.rebar --force

ENV MIX_ENV=prod

COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

COPY assets/package.json assets/package-lock.json

COPY assets assets

RUN mix phx.digest

COPY priv priv
COPY lib lib

RUN mix do compile, release

COPY docker_dev_start.sh docker_dev_start.sh

EXPOSE 4000

