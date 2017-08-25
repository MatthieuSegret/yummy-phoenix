defmodule YummyWeb.RecipeController do
  use YummyWeb, :controller
  alias Yummy.Recipes.Recipe

  plug :put_recipe when action in [:show, :delete]    

  def index(conn, _params) do
    recipes = Recipe |> Repo.all
    render conn, "index.html", recipes: recipes
  end

  def show(conn, %{"id" => id}) do
    render conn, "show.html", recipe: conn.assigns[:recipe]
  end

  def delete(conn, _params) do
    {:ok, _recipe} = conn.assigns[:recipe] |> Repo.delete
    conn
    |> put_flash(:notice, "La recette a bien été supprimé.")
    |> redirect(to: recipe_path(conn, :index))
  end

  ## Private
  defp put_recipe(conn, _) do
    recipe = Recipe |> Repo.get!(conn.params["id"])
    assign(conn, :recipe, recipe)
  end
end