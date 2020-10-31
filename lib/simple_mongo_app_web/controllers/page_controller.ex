defmodule SimpleMongoAppWeb.PageController do
  use SimpleMongoAppWeb, :controller

  alias SimpleMongoApp.Article

  def index(conn, _params) do
    render conn, "index.html"
  end

end
