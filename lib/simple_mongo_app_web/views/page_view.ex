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

  @types ~w[function nil integer binary bitstring list map float atom tuple pid port reference]
  for type <- @types do
    def typeof(x) when unquote(:"is_#{type}")(x), do: unquote(type)
  end

  defp stringify_key_val( key, val ) do
    if typeof( val ) == "binary" do # It might be a BSONObject(HEXNUMBER) - skip it
      "#{key}: #{val}; "
    else
      ""
    end
  end

  defp stringify_keys( keys, map ) do
    case keys do
      [] -> ""
      [hd | tl] ->
        key = List.first( keys )
        stringify_key_val( key, map[ key ]) <> stringify_keys( tl, map )
    end
  end

  defp stringify_map( map ) do
    { "1", stringify_keys( Map.keys( map ), map ) }
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
