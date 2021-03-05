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

***
## Recursos Utilizados

* [Documentación Oficial de Ruby](https://guides.rubyonrails.org/)
* [Tutorial de Vue 3 con Rails](https://dev.to/vannsl/vue3-on-rails-l9d#install-npm-packages)
* [Setup de Vue con proyecto existente de Rails (Ver step_by_step.md)](https://gist.github.com/stungeye/65558d2d7d03356754a3ede55f6fcf31)
* [Tutorial para integrar API con Rails](https://medium.com/@ryanwaldorf/how-to-add-an-api-to-an-existing-rails-app-1d2419ba91bd)
* [AccuWeather](https://developer.accuweather.com/)
