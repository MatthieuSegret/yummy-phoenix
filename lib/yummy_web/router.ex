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

    get "/recipes", RecipeController, :index
    get "/recipes/new", RecipeController, :new
    post "/recipes", RecipeController, :create
    get "/recipes/:id", RecipeController, :show
    delete "/recipes/:id", RecipeController, :delete
    get "/", RecipeController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", YummyWeb do
  #   pipe_through :api
  # end
end
