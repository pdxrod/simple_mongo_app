# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :simple_mongo_app, SimpleMongoAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "J8gnBt8Qs20PgyzAh2BrmmM5ib4/FTerKxSQAj1j1HM7QFMnTGT9P7hnbvyMnbLr",
  render_errors: [view: SimpleMongoAppWeb.ErrorView, accepts: ~w(html json)]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :simple_mongo_app, timings: {27, 17, 170}

config :simple_mongo_app, debugging: true

config :simple_mongo_app, your_config: [
  username: "foo",
  password: "baz",
  realm: "Admin Area"
]

config :simple_mongo_app, my_config: [
  username: "foo",
  password: "bar",
  realm: "Admin Area"
]

import_config "#{Mix.env}.exs"
