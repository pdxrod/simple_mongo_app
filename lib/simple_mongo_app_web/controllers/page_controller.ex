defmodule SimpleMongoAppWeb.PageController do
  use SimpleMongoAppWeb, :controller

  @save_button_reg ~r/save_button_.+/
  @decaf0ff "decaf0ff"

  defp print_keys( keys, map ) do
    case keys do
      [] ->
        @decaf0ff
      [hd | tl] ->
        if hd =~ @save_button_reg do
          id = String.slice( hd, 12..-1)
          IO.puts "id #{id}"
          id
        end
        IO.puts "#{hd} #{map[ hd ]}"
        print_keys tl, map
    end
  end

  defp get_id( params ) do
    keys = Map.keys params
    print_keys keys, params
  end

 # %{classification" => "man", "name" => "Joan", "new_column" => "gender", "save_button_5f9d7adca9f74f0c6b94623b" => ""}
  defp analyze_params( params ) do
    id = get_id params
    if id != @decaf0ff do # User is attempting to save an article

    end
  end

  def index(conn, params) do
    analyze_params params
    render conn, "index.html"
  end

end
