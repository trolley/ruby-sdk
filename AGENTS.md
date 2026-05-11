# AGENTS.md

Ruby SDK for the [Trolley](https://trolley.com) payments API. Pure gem — no databases or background services.

## Development

Requires Ruby 3.2.2 (see `.ruby-version`). Setup and test commands are in `CONTRIBUTING.md`. Quick reference:

```
bundle install                        # install deps
bundle exec rubocop                   # lint
bundle exec rake unit_tests           # unit tests only
bundle exec rake integration_tests    # integration tests only
bundle exec rake                      # all tests
gem build trolley.gemspec             # build gem
```

## Testing without API keys

Integration tests use VCR cassettes (`test/fixtures/`). Copy `.env.template` to `.env` — the fake keys are sufficient for cassette playback. No live API access is needed to run the full test suite.

## Testing with live API

To re-record cassettes or test against the sandbox, add real credentials from [developers.trolley.com](https://developers.trolley.com) to `.env`:

```
SANDBOX_API_KEY=<your access key>
SANDBOX_SECRET_KEY=<your secret key>
```
