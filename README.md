# Coding Exercise for Crawling Utility Websites

## To setup your machine locally:
```
$ gem install bundler
$ bundle
$ cp .env.sample .env

```
Then update your .env file with the appropriate username & password.

This project uses phantomjs to do headless browser crawling. If you do not already have it installed:
```
$ npm install -g phantomjs
```

To run the main script:
```
$ ./main.rb
```

To run the tests:
```
$ ruby test.rb
```
