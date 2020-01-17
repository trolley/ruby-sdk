## Running the Rake Test Suite

First `bundle install`

#### Running all the tests 

`bundle exec rake`

#### Running just the unit tests 

`bundle exec rake unit_tests`

#### Running just the integration tests

Integration tests have a dependency on the real API, therefore you need credentials.

To add credentials, this gem uses `dotenv` to inject credential ENV variables:

1. copy the env template `cp .env.template .env`
1. add your configuration there **NOTE: preferrably use sandbox values -- integration tests run real requests**

`bundle exec rake integration_tests`
