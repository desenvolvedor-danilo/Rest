FROM ubuntu/postgres:latest AS build
RUN apt-get update
RUN su postgres
RUN psql
RUN \password
RUN postgres
RUN CREATE DATABASE api_rest;
RUN \q
RUN exit
RUN systemctl restart postgresql
RUN apt-get install openjdk-17-jdk -y
RUN apt-get install maven -y
COPY . .

FROM openjdk:17-jdk-slim

EXPOSE 8000

COPY --from=build /target/rest-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT [  "java","-jar","app.jar"  ]
