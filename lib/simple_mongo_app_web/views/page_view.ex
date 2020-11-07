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
    if typeof( val ) == "binary" do
      "<input id='#{key}' name='#{key}' type='text' value='#{val}'>"
    else
      str = Base.encode16(val.value, case: :lower)
      "#{ str }" # It's a %BSON.ObjectId{value: "HEXNUM"}
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
    str = stringify_keys( Map.keys( map ), map )
    id = String.slice str, 0..23
    str = String.slice str, 24..-1
    { id, str } # id is the first 24 characters of the string returned by stringify_keys - str is the rest of it
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

  def find_article( id, articles_list ) do
    case articles_list do
      [] -> ""
      [ hd | tl ] ->
        str = elem( hd, 0 )
        if id == str do
          str <> " " <> elem( hd, 1 )
        else
          find_article id, tl
        end
    end
  end

  def show_articles do
    try do
      start_mongo
      articles
    rescue
      re in RuntimeError -> re
      ["e", "Error: #{ re.message }"] # {:error, {:already_started, #PID<0.451.0>}}
    end
  end

end
