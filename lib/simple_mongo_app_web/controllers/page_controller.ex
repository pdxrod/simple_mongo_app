defmodule SimpleMongoAppWeb.PageController do
  use SimpleMongoAppWeb, :controller

  alias SimpleMongoApp.Article

  def index(conn, _params) do
    articles = []
    render(conn, "index.html", articles: articles)
  end

end
