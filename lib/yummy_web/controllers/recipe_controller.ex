defmodule YummyWeb.RecipeController do
  use YummyWeb, :controller
  alias Yummy.Recipes.Recipe

  def index(conn, _params) do
    recipes = Recipe |> Repo.all
    render conn, "index.html", recipes: recipes
  end
end