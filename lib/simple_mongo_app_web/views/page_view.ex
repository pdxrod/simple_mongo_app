defmodule SimpleMongoAppWeb.PageView do
  use SimpleMongoAppWeb, :view

  def article_count do
    Mongo.start_link(
      name: :mongo,
      database: "my_app_db",
      hostname: "localhost",
      username: "root",
      password: "rootpassword"
    )
    tuple = Mongo.count(:mongo, "my_app_db", %{})
    if elem( tuple, 0 ) == :ok do
      "#{ elem( tuple, 1 ) }"
    else
      "Error: #{ elem( tuple, 0 ) }"
    end 
  end
end
