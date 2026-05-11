## Cursor Cloud specific instructions

This is the **Trolley Ruby SDK** — a Ruby gem wrapping the Trolley payments API. No databases or background services are required.

### Quick reference

| Task | Command |
|---|---|
| Install deps | `bundle install` |
| Lint | `bundle exec rubocop` |
| Unit tests | `bundle exec rake unit_tests` |
| Integration tests | `bundle exec rake integration_tests` |
| All tests | `bundle exec rake` |
| Build gem | `gem build trolley.gemspec` |

### API keys

Sandbox credentials go in `.env` (loaded by `dotenv`). The file has two required variables:

```
SANDBOX_API_KEY=<your access key>
SANDBOX_SECRET_KEY=<your secret key>
```

Get sandbox keys from [developers.trolley.com](https://developers.trolley.com). In Cloud Agent environments these are injected as env vars via Cursor Secrets (`SANDBOX_API_KEY`, `SANDBOX_SECRET_KEY`).

### Important notes

- Ruby 3.2.2 is required (see `.ruby-version`). It is installed at `/usr/local/bin/ruby`.
- Integration tests use VCR cassettes in `test/fixtures/` and do **not** need live API credentials. The `.env` file with fake keys (copied from `.env.template`) is sufficient for cassette playback.
- To re-record VCR cassettes or run live integration tests, set real `SANDBOX_API_KEY` and `SANDBOX_SECRET_KEY` in `.env`. See `CONTRIBUTING.md`.
- The gem has no runtime dependencies; all deps in the gemspec are `add_development_dependency`.
