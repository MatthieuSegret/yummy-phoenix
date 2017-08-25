defmodule YummyWeb.Router do
  use YummyWeb, :router

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

  scope "/", YummyWeb do
    pipe_through :browser # Use the default browser stack

    get "/recipes/search", RecipeController, :search
    resources "/recipes", RecipeController
    get "/", RecipeController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", YummyWeb do
  #   pipe_through :api
  # end
end
