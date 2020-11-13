defmodule SimpleMongoAppWeb.PageView do
  use SimpleMongoAppWeb, :view

  @new_column_field "new column <input id='new_column' name='new_column' type='text' value=''> "
  @new_column_reg ~r/new column <input id='new_column' name='new_column' type='text' value/

  @types ~w[function nil integer binary bitstring list map float atom tuple pid port reference]
  for type <- @types do
    def typeof(x) when unquote(:"is_#{type}")(x), do: unquote(type)
  end

  defp stringify_key_val( key, val ) do
    if typeof( val ) == "binary" do
      if key == "_id" do
        val                # It's a hex string
      else
        "#{key} <input id='#{key}' name='#{key}' type='text' value='#{val}'><br/>\n"
      end
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
    if str =~ @new_column_reg do
      [{ id, str }] # id is the first 24 characters of the string returned by stringify_keys - str is the rest of it
    else
      [{ id, str <> @new_column_field }]
    end
  end

  defp stringify_list( list ) do
    case list do
      [] -> []
      [hd | tl] -> stringify_map( hd ) ++ stringify_list( tl )
    end
  end

  defp empty_row do
    id = String.slice( RandomBytes.base16, 0..23 )
    map = %{ name: "", classification: "" }
    str = stringify_keys( Map.keys( map ), map )
    [{ id, str <> @new_column_field }]
  end

  defp articles do
    cursor = Mongo.find(:article, "my_app_db", %{})
    list = cursor |> Enum.to_list() |> stringify_list
    list ++ empty_row
  end

  def show_articles do
    try do
      articles()
    rescue
      re in RuntimeError -> re
      [ { "decaf0ff", "Error: #{ re.message }" } ]
    end
  end

end
