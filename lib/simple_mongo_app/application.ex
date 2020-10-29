defmodule SimpleMongoApp.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(SimpleMongoAppWeb.Endpoint, []),
      worker(
             Mongo,
             [[
               database: "my_app_db",
               hostname: "localhost",
               username: "root",
               password: "rootpassword"
             ]]
           )
    ]

    opts = [strategy: :one_for_one, name: SimpleMongoApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    SimpleMongoAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
