```
@dmarcoux/Berlin-Demographie-Vornamen

Learning Sinatra by building an API with PostgreSQL, Sequel and Minitest.
```

**TODO**

1. Get rid of `Sequel.migration` and use plain SQL instead
2. Use plain SQL migration in the Docker Compose 'db' service (See section 'How to extend this image': https://hub.docker.com/_/postgres/)

# Introduction

I am learning Sinatra with this project. I chose to build an API and I don't have a specific list of things I want to accomplish. I simply want to learn by doing.

# Data

I took the data on this website http://daten.berlin.de/kategorie/demographie, more specifically the CSV files under *Liste der häufigen Vornamen 2014*. It lists the newborn names separated by sex and broken down by the neighborhoods.

# Usage

Using Docker and Docker Compose simplifies development.

## Application

Run the application with `docker-compose up development`

## Specs

Run specs with `docker-compose up test`
