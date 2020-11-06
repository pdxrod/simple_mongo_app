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

  @types ~w[function nil integer binary bitstring list map float atom tuple pid port reference]
  for type <- @types do
    def typeof(x) when unquote(:"is_#{type}")(x), do: unquote(type)
  end

  defp stringify_key_val( key, val ) do
    if typeof( val ) == "binary" do
      "#{key} - #{val} "
    else
      ""
    end
  end

  defp stringify_keys( keys, map ) do
    case keys do
      [] -> ""
      [hd | tl] -> stringify_key_val( List.first( keys), map[ List.first( keys ) ]) <> stringify_keys( tl, map )
    end
  end

  defp stringify_map( map ) do
    stringify_keys( Map.keys( map ), map )
  end

  defp stringify_list( list ) do
    case list do
      [] -> []
      [hd | tl] -> [ stringify_map hd ] ++ stringify_list( tl )
    end
  end

  defp articles do
    cursor = Mongo.find(:article, "my_app_db", %{})
    cursor |> Enum.to_list() |> stringify_list
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
