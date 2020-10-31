defmodule SimpleMongoAppWeb.PageController do
  use SimpleMongoAppWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

end
