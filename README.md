# 青空文庫APIサーバー

青空文庫APIサーバー

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

## Usage

    $ git clone git@github.com:blockgiven/aozora-api-server.git
    $ cd aozora-api-server
    $ bundle install
    $ bundle exec rails s

## Endpoint

### GET /books/random.json

information about an book.

- title
- url
- opening_sentence

### GET /books/random/sentences/1.txt

first sentence of an book.
