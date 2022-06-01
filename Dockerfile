FROM alpine:3.16 AS base

#change workdir to app folder
WORKDIR /app

#copy to app folder
COPY . .

#install npm, it's dependencies and then build
RUN apk add npm \
    && npm install \
    && npm run build



FROM alpine:3.16

WORKDIR /app

COPY --from=base /app/dist .

RUN apk add npm && npm install -g serve

CMD ["serve", "-s", "."]