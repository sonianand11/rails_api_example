#### 
  This Ruby on Rails 7 api only application can used to quickly start development using JWT authentication token.

### Database Configuration
- create `config/database.yml` and add following content
```
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  database: <%= ENV.fetch("DATABASE_NAME") %>
  username: <%= ENV.fetch("DATABASE_USERNAME") %>
  password: <%= ENV.fetch("DATABASE_PASSWORD") %>
  host: <%= ENV.fetch("DATABASE_HOST") %>
  port: 5432

development:
  <<: *default

test:
  <<: *default

```
- Setup database using `rails db:create db:migrate`

### Environment variables
- create `.env.development.local` for development
- create `.env.test.local` for test

#### Content of environment files are
```sh
POSTGRES_USER=
POSTGRES_PASSWORD=
POSTGRES_DB=
POSTGRES_HOST=
```
*Note*: Since docker postgres image consider POSTGRES_ prefix as environment variable, we are using it.

### Testing
- RSpec is used for testing. Run `rspec` command to test

### Server start
- Run `rails s` to start server

### Start server using Docker
- [Install docker](https://docs.docker.com/engine/install/) in machine if not already
- Build image using docker compose
```
sudo docker compose up --build
```