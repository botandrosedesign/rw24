# RW24

[![Build Status](https://travis-ci.org/botandrose/rw24.svg?branch=master)](https://travis-ci.org/botandrose/rw24)
[![Coverage Status](https://coveralls.io/repos/botandrose/rw24/badge.svg?branch=master&service=github)](https://coveralls.io/github/botandrose/rw24?branch=master)
[![Code Climate](https://codeclimate.com/github/botandrose/rw24/badges/gpa.svg)](https://codeclimate.com/github/botandrose/rw24)

Riverwest 24 Website and Scoring System

## Requirements

* Linux OS (probably works on MacOS, but untested)
* Ruby 2.x
* Bundler 1.x
* MySQL 5.x (probably works on Postgres and Sqlite, but untested)
* JavaScript Runtime (NodeJS, Rhino, etc)

## Get Started
```bash
git clone git@github.com:botandrose/rw24.git
cd rw24
bin/setup
bin/rails server
```
View the site at [http://localhost:3000](http://localhost:3000) and follow the installation instructions.

## TODO
* Easy import/export of content, except for user accounts. Anyone should be able to import riverwest24.com content.
* Documentation on how to administer the site.
* Better acceptance test coverage.
* Better unit test coverage.
* Any javascript unit test coverage at all!
* Refactoring, especially jquery soup.
* Bonus model needs to be reworked. Inline JSON is not working out well.
* Modernize stylesheets, still using old SASS syntax
* Extract to Rails Engine for easier reuse for other races?

## Contributing

1. Fork it ( https://github.com/botandrose/rw24/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
