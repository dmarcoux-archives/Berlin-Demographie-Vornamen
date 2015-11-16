```
@dmarcoux/Berlin-Demographie-Vornamen

Learning Sinatra by building an API with PostgreSQL, Sequel, Dotenv and Minitest.
```

####TODO
1. Fix all Rubocop issues
2. Setup CodeClimate
3. Setup Guard
4. Improve README.md with examples on how to run specs, run the server, etc...
5. Setup Mutant

#Introduction

I am learning Sinatra with this project. I chose to build an API and I don't have a specific list of things I want to accomplish. I simply want to learn by doing.

#Data

I took the data on this website http://daten.berlin.de/kategorie/demographie, more specifically the CSV files under *Liste der häufigen Vornamen 2014*. It lists the newborn names separated by sex and broken down by the neighborhoods.

#Usage
##Application

Run the application with `bundle exec rackup`.

##Specs

Run specs with `RACK_ENV=test bundle exec rake test`. Setting the environment variable `RACK_ENV` isn't mandatory, but you should always set it if you don't want to alter your development database.

##Rubocop


##Guard


##Mutant
