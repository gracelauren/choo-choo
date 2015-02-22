Train System DB
================

by Grace Mekarski

Train System DB is a website that uses a Active Record and Sinatra to allow train operators and passengers to track train lines and stations.

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
$ rake db:create
```

```
$ rake db:schema:load

```

```
$ rake db:test:prepare

```


Start the webserver:
```
$ ruby app.rb
```

In your web browser, go to http://localhost:4567
```

License
-------

GNU GPL v2. Copyright 2015 Grace Mekarski
