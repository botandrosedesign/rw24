# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Application Overview

RW24 is the Riverwest 24 website and scoring system — a Rails app for managing a 24-hour bicycle race in Milwaukee, WI. Teams (solo, tandem, small/large) accumulate laps and bonus checkpoint points over 24 hours.

## Stack

- Ruby 3.3.4, Rails ~8.0 (with `config.load_defaults 7.0`)
- MySQL via `trilogy` adapter (database: `rw24`, test: `rw24_test`)
- HAML and Slim templates
- Importmap + Stimulus (no Node/Webpacker)
- Sprockets + Dart Sass for CSS
- `adva` CMS gem provides Site, Section, Page, Article, User models and admin UI
- `delayed_job_active_record` for background jobs

## Commands

```bash
bin/setup                    # install deps, seed db, clear cache
bin/rails server             # start dev server
bin/rake bootstrap           # seed db + clear cache

# RSpec (unit/model specs — uses in-memory SQLite, NOT MySQL)
bundle exec rspec
bundle exec rspec spec/models/race_spec.rb
bundle exec rspec spec/models/race_spec.rb:15

# Cucumber (acceptance tests — uses Capybara + Cuprite headless Chrome + MySQL)
# NEVER run the full suite — it is extremely slow
bundle exec cucumber features/manage_races.feature
bundle exec cucumber features/manage_teams.feature:25

# CI
bin/ci
```

No linter (RuboCop etc.) is configured.

## Architecture

### Domain Models

- **Race** — a single running of the event (year, start_time, published, settings store with bonuses as JSON, categories via json_associations)
- **Team** — registered team for a race (position, name, category, riders, points; uses `acts_as_list`)
- **TeamCategory** — categories like "A Team", "Solo (male)", "Tandem" (seeded from `db/seeds.rb`)
- **Rider** — team member (belongs to Team, optionally to User)
- **User** — rider profile persisting across races (provided by adva gem, extended in initializers)
- **Point** — scored event: "Lap" (qty=1), "Bonus" (positive), or "Penalty" (negative)
- **Bonus** — non-persisted value object for bonus checkpoints (stored as JSON in Race settings)

### Controller Patterns

- `ApplicationController` defines the `expose` helper (creates `attr_reader` + `helper_method`), `current_race`, and `guess_section`
- Public: `TeamsController`, `PointsController`, `AccountsController`, `ConfirmationsController`, `EmailsController`
- Admin: `Admin::RacesController`, `Admin::TeamsController`, `Admin::BonusesController`, `Admin::ConfirmationEmailsController`, `Admin::DatabasesController`
- Adva extensions live in `config/initializers/adva_extensions/`

### Test Setup

- RSpec model specs load models directly without Rails, using an in-memory SQLite database (`spec/ar_helper.rb`). Seeds are loaded via `load "db/seeds.rb"`.
- Cucumber uses MySQL test database. The `Before` hook in `features/support/setup.rb` creates a Site, admin User, and homepage Article before each scenario.
- Factories are in `features/support/factories.rb` (shared by both frameworks).
- For parallel Cucumber runs, use `TEST_ENV_NUMBER=N` prefix to avoid database conflicts.

### Background Jobs & Cron

- `delayed_job` for async work (e.g., `team.delay.send_confirmation_email!`). Disabled in test env.
- `whenever` gem runs `rake cache_leaderboard` every minute in production to statically generate leaderboard HTML in `public/leader-board/`.

### Deployment

- `bard deploy` (botandrose/bard-rails)
- Production uses systemd user services via foreman, managed with `rake restart`
