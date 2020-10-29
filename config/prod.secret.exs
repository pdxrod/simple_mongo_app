use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :simple_mongo_app, SimpleMongoAppWeb.Endpoint,
  secret_key_base: "ch6hXA7gd4Ka6BwlOVk/b0J9CZqZ0Ms+orwEgNX7McVWC1HYcJQVeOCWZ+y+clgF"

# Configure your database
config :simple_mongo_app, SimpleMongoApp.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "simple_mongo_app_prod",
  pool_size: 15
