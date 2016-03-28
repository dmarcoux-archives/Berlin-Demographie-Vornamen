```
@dmarcoux/Berlin-Demographie-Vornamen

Learning Sinatra by building an API with PostgreSQL, Sequel and Minitest.
```

**TODO**

1. service for test database (change rake tasks under namespace db)
2. db/seeds in plain SQL for development database

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
