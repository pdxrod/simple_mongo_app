defmodule SimpleMongoAppWeb.PageView do
  use SimpleMongoAppWeb, :view

  defp start_mongo do
    Mongo.start_link(
      name: :article,
      database: "my_app_db",
      hostname: "localhost",
      username: "root",
      password: "rootpassword"
    )
  end

  defp article_count do
    tuple = Mongo.count(:article, "my_app_db", %{})
    if elem( tuple, 0 ) == :ok do
      "#{ elem( tuple, 1 ) }"
    else
      "Error: #{ elem( tuple, 0 ) }"
    end
  end

  def show_article_count do
    try do
      start_mongo
      article_count
    rescue
      re in RuntimeError -> re
      "Error: #{ re.message }"
    end
  end

  defp articles do
    cursor = Mongo.find(:article, "my_app_db", %{})
    cursor
      |> Enum.to_list()
  end

  def show_articles do
    try do
      start_mongo
      articles
    rescue
      re in RuntimeError -> re
      "Error: #{ re.message }"
    end
  end

end
