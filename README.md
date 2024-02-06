# README

## Basic configurations

Project created with command

```bash
rails new . -j esbuild --database postgresql --skip-test --css bootstrap
```

Ruby version: `3.3.0`
Rails version: `7.1.3`
Database: `postgresql`
Testing with: `rspec`

Views are written in `slim`

Javascript and Css bundled with `esbuild`
Css with `bootstrap`

Forms with `simple_form`

Linters: `rubocop`, `rubocop-rspec`, `slim_lint`

## Setup

Run:

```bash
bin/setup
```

Check application by starting server:

```bash
bin/dev
```

---

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
