defmodule YummyWeb.RecipeController do
  use YummyWeb, :controller
  alias Yummy.Recipes.Recipe

  def index(conn, _params) do
    recipes = Recipe |> Repo.all
    render conn, "index.html", recipes: recipes
  end

  def show(conn, %{"id" => id}) do
    recipe = Recipe |> Repo.get!(id)
    render conn, "show.html", recipe: recipe
  end
end