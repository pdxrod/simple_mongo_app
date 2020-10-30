defmodule SimpleMongoApp.ArticleController do
  use SimpleMongoAppWeb, :controller

  alias SimpleMongoApp.Article

  def index(conn, _params) do
    articles = Repo.all(Article)
    render(conn, "index.html", articles: articles)
  end

end
