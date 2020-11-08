defmodule SimpleMongoAppWeb.PageController do
  use SimpleMongoAppWeb, :controller

  @save_button_reg ~r/save_button_.+/
  @decaf0ff "decaf0ff"

  defp find_id( keys, map ) do
    case keys do
      [] ->
        @decaf0ff
      [hd | tl] ->
        if hd =~ @save_button_reg do
          id = String.slice( hd, 12..-1)
          IO.puts "id #{id}"
          id
        else
          IO.puts "#{hd} #{map[ hd ]}"
          find_id tl, map
        end
    end
  end

  defp find_save_button_key( keys ) do
    case keys do
      [] -> @decaf00f
      [hd | tl] ->
        if hd =~ @save_button_reg do
          hd
        else
          find_save_button_key tl
        end
    end
  end

  defp remove_unwanted_keys( args ) do
 # "_csrf_token" => "UCwUFn5PbBw9FSNpMR0aRyk8MDkdOgYa4gECM56NsyaZCUhqfIwKQPVE",
 # "_id" => #BSON.ObjectId<5fa793f09dad02e8eae18e33>, "classification" => "man",
 # "name" => "John", "new_column" => "gender", "save_button_5f9d79c5a9f74f0bfb2cb5cc" => ""
   map = Map.delete( args, "_csrf_token" )
   map = Map.delete( map, "_id" )
   key = find_save_button_key( Map.keys( map ))
   Map.delete( map, key )
  end

 # %{classification" => "man", "name" => "Joan", "new_column" => "gender", "save_button_5f9d7adca9f74f0c6b94623b" => ""}
  defp analyze_params( params ) do
    id = find_id( Map.keys( params ), params )
    if id == @decaf0ff do # User is attempting to save an article
      IO.puts "Not found"
    else
# This 'id = id <> <<0>>' turns "5f9d79c5a9f74f0bfb2cb5cc" into
# <<53, 102, 57, 100, 55, 97, 100, 99, 97, 57, 102, 55, 52, 102, 48, 99, 54, 98, 57, 52, 54, 50, 51, 98, 0>>
      id = id <> <<0>>
      obj_id = %BSON.ObjectId{ value: id }
      IO.puts "\nFinding by object id"
      article = remove_unwanted_keys params
      article = %{_id: id, name: "Jim", classification: "woman"}
      {:ok, new_article} = Mongo.find_one_and_replace(:article, "my_app_db", article, article, [return_document: :after, upsert: :true])
  #    {:ok, new_article} = Mongo.find_one_and_update(:article, "article", article,  %{"$set" => article}, [return_document: :after])
      c = new_article["classification"]
      n = new_article["name"]
      nc = new_article["new_column"]
      IO.puts "Found and replaced article #{c} #{n} #{nc}"
    end
  end

  def index(conn, params) do
    analyze_params params
    render conn, "index.html"
  end

end
