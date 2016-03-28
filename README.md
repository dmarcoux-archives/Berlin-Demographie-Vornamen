```
@dmarcoux/Berlin-Demographie-Vornamen

Learning Sinatra by building an API with PostgreSQL, Sequel and Minitest.
```

**TODO**

1. Automate DB migrations and seeds.
  * .sql files under /docker-entrypoint-initdb.d/ in postgres image
  * Sequel migrations run plain SQL [here](http://sequel.jeremyevans.net/rdoc/files/doc/migration_rdoc.html#label-Schema+methods), look for 'If you need to drop down to SQL to execute some database specific code'

# Introduction

I am learning Sinatra with this project. I chose to build an API and I don't have a specific list of things I want to accomplish. I simply want to learn by doing.

# Data

I took the data on this website http://daten.berlin.de/kategorie/demographie, more specifically the CSV files under *Liste der häufigen Vornamen 2014*. It lists the newborn names separated by sex and broken down by the neighborhoods.

# Usage

Using Docker and Docker Compose simplifies development.

## Application

Run the application with `docker-compose up development`

## Migrations

Run migrations with `docker-compose run SERVICE_NAME bundle exec rake db:migrate`. Needed for development and test.

## Specs

Run specs with `docker-compose up test`
