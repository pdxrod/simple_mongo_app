defmodule ArticleTest do
  use SimpleMongoAppWeb.ConnCase
  alias SimpleMongoApp.Utils

  describe "articles" do

    test "typeof" do
      assert "binary" == Utils.typeof( "Hello" )
      assert "list" == Utils.typeof( 'Hello' )
      assert "list" == Utils.typeof( [:a, :b] )
      assert "atom" == Utils.typeof( :foo )
      assert "map" == Utils.typeof( %{} )
      assert "map" == Utils.typeof( %{foo: :bar} )
      assert "tuple" == Utils.typeof( {:foo, "Hello"} )
    end

  end
end
