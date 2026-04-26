# Automerge Syndrome

A Rails 7 application for FitnessFormula, configured with TailwindCSS and Rails-focused RuboCop.

## Setup

```sh
bundle install
bin/rails db:prepare
```

## Development

```sh
bin/rails server
```

Open <http://localhost:3000/>.

For Tailwind watch mode, run:

```sh
bin/dev
```

## Verification

```sh
bin/rails test
bin/rails tailwindcss:build
bundle exec rubocop
```
