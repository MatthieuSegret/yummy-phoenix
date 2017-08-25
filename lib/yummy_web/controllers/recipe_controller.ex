defmodule YummyWeb.RecipeController do
  use YummyWeb, :controller
  alias Yummy.Recipes
  alias Yummy.Recipes.Recipe

  plug :put_recipe when action in [:show, :edit, :update, :delete]    

  def index(conn, params) do
    {recipes, kerosene} = Recipe
      |> order_by(desc: :inserted_at)
      |> Repo.paginate(params)
    render conn, "index.html", recipes: recipes, keywords: nil, kerosene: kerosene
  end

  def search(conn, %{"keywords" => keywords} = params) do
    {recipes, kerosene} = Recipe
      |> Recipes.search_recipes(keywords)
      |> Repo.paginate(params)
    render conn, "index.html", recipes: recipes, keywords: keywords, kerosene: kerosene
  end

  def show(conn, _params) do
    render conn, "show.html", recipe: conn.assigns[:recipe]
  end

  def new(conn, _params) do
    changeset = Recipe.changeset(%Recipe{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"recipe" => recipe_params}) do
    case Recipes.create_recipe(recipe_params) do
      {:ok, recipe} ->
        conn
        |> put_flash(:info, "La recette a bien été créée.")
        |> redirect(to: recipe_path(conn, :show, recipe))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, _params) do
    changeset = Recipe.changeset(conn.assigns[:recipe])
    render conn, "edit.html", changeset: changeset
  end

  def update(conn, %{"recipe" => recipe_params}) do
    case Recipes.update_recipe(conn.assigns[:recipe], recipe_params) do
      {:ok, recipe} ->
        conn
        |> put_flash(:info, "La recette a bien été créée.")
        |> redirect(to: recipe_path(conn, :show, recipe))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
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