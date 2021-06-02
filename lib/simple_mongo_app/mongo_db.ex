defmodule SimpleMongoApp.MongoDb do

  def start_link do
    Mongo.start_link(
      name: :article,
      database: "my_app_db",
      hostname: "localhost",
      username: "root",
      password: "rootpassword"
    )
  end

  def find_one( id ) do
    Mongo.find_one(:article, "my_app_db", %{"_id" => id})
  end

  def find_one_and_replace( old_article, new_article ) do
    Mongo.find_one_and_replace(:article, "my_app_db", old_article, new_article, [return_document: :after, upsert: :true])
  end

  def articles() do
    Mongo.aggregate(:article, "my_app_db", [ %{ "$sort" => %{ "datetime" => -1, "_id" => 1 }} ]) |> Enum.to_list
  end

  def delete_one( id ) do
    Mongo.delete_one( :article, "my_app_db", %{_id: id} )
  end

  def find do
    Mongo.find(:article, "my_app_db", %{}) |> Enum.to_list()
  end

end
