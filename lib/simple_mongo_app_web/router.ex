defmodule SimpleMongoAppWeb.Router do
  use SimpleMongoAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SimpleMongoAppWeb do
    pipe_through :browser
    post "/", PageController, :index
    get "/", PageController, :index
  end

  scope "/articles", SimpleMongoAppWeb do
    pipe_through :browser
    get "/articles", ArticleController, :index
  end
end
