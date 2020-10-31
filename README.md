# SimpleMongoApp

Found clear instructions for how to connect Phoenix to MongoDB at https://medium.com/swlh/setup-phoenix-on-docker-with-mongodb-d411e24dd78c

The only things missing are these:

Before starting Phoenix with `mix phx.server` -

In the MongoDB console ('mongo') you have to do this:
   `use my_app_db`

Then
   `db.article.insert({name: "Ada Lovelace", classification: "programmer"})`

Enter
   `show dbs`

And you should see 'my_app_db' listed

Now you can do the following
```
  db.createCollection("my_collection")
  db.createUser(
   {
    user: "root",
    pwd: "rootpassword",
    roles: [
      {
        role: "dbOwner",
        db: "my_app_db"
      }
    ]
   }
  )
```

NOW start Phoenix, and it should connect using the information in application.ex:
```
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
```

See https://www.mongodb.com/basics/create-database
