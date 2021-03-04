# Plantilla usada en el curso IIC3745: Testing, Se puede encontrar [ACÁ](https://github.com/IIC3745-2020-2/example)

## Development setup

* `touch .env`
* `docker-compose build`
* `docker-compose run --rm web bundle install`
* `docker-compose run --rm web yarn install`
* `docker-compose run --rm web rails db:create db:schema:load`
* Copy `development.key` inside `config/credentials`
* `docker-compose up -d`
* Open `localhost:3000` with any browser

### Run tests and linters

* Run almost all: `docker-compose exec web rake`
* `docker-compose exec web bundle exec rspec`
* `docker-compose exec web yarn eslint`
* `docker-compose exec web rake scss_lint`
* `docker-compose exec web rubocop`
* `docker-compose exec web rake erblint`
* `docker-compose exec web bundle-audit check --update`
* `docker-compose exec web brakeman -z -q`

### Development tips

* Check new versions of gems: `docker-compose exec web bundle outdated --no-local`
* Clear docker space on disk: `docker system prune -a --volumes`
* Edit credentials: `docker-compose run --rm web rails credentials:edit --environment X`
* Fix eslint offences automatically: `docker-compose exec web yarn run eslint --fix --ext .js,.es6 app/javascript`
* Fix rubocop offences automatically: `docker-compose exec web rubocop -a`
* Fix erblint offences automatically: `docker-compose exec web bundle exec erblint --lint-all -a`
