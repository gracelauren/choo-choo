Train System DB
================

by Grace Mekarski and Karvari Ellingson

Train System DB is a website that uses a database and Sinatra to allow train operators and passengers to track train lines and stations.

Installation
------------

Install Train System DB by first cloning the repository.  
```
$ git clone http://github.com/gracelauren/choo-choo.git
```

Install all of the required gems:
```
$ bundle install
```

Start the database:
```
$ postgres
```

Create the databases and tables:
```
# psql
```

```
username=# CREATE DATABASE train_system;
```

```
username=# \c train_system;
```

```
todo=# CREATE TABLE lines (id serial PRIMARY KEY, name varchar);
```

```
todo=# CREATE TABLE stations (id serial PRIMARY KEY, name varchar);
```

```
CREATE TABLE stops (id serial PRIMARY KEY, station_id int, line_id int);
```

```
todo=# CREATE DATABASE train_system_test WITH TEMPLATE train_system;
```

Start the webserver:
```
$ ruby app.rb
```

In your web browser, go to http://localhost:4567

License
-------

GNU GPL v2. Copyright 2015 Karvari Ellingson and Grace Mekarski
