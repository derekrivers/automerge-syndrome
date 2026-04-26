# Automerge Syndrome

Automerge Syndrome is a Rails 7 marketing site scaffolded with Tailwind CSS compiled through the Rails asset pipeline.

## Requirements

- Ruby 3.2.2
- Bundler
- SQLite 3

## Setup

```sh
bundle install
bin/rails db:prepare
```

## Development

Start Rails and the Tailwind CSS watcher:

```sh
bin/dev
```

For a Rails-only boot check:

```sh
bin/rails server
```

## Tests and linting

```sh
bin/rails test
bundle exec rubocop
```
