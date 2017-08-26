defmodule YummyWeb.RecipeController do
  use YummyWeb, :controller
  alias Yummy.Recipes
  alias Yummy.Recipes.{Recipe, Comment}

  plug Coherence.RequireLogin when action in [:create, :update, :new, :edit, :delete]    
  plug :put_recipe when action in [:edit, :update, :delete]
  plug :is_owner when action in [:edit, :update, :delete]  

  def index(conn, params) do
    {recipes, kerosene} = Recipe
      |> order_by(desc: :inserted_at)
      |> preload(:user)
      |> Repo.paginate(params)
    render conn, "index.html", recipes: recipes, keywords: nil, kerosene: kerosene
  end

  def search(conn, %{"keywords" => keywords} = params) do
    {recipes, kerosene} = Recipe
      |> Recipes.search_recipes(keywords)
      |> preload(:user)
      |> Repo.paginate(params)
    render conn, "index.html", recipes: recipes, keywords: keywords, kerosene: kerosene
  end

  def show(conn, %{"id" => id}) do
    recipe = Recipe
    |> preload([{:comments, :user}, :user])        
    |> Repo.get!(id)

    comment_changeset = %Comment{} |> Comment.changeset
    render conn, "show.html", comment_changeset: comment_changeset, recipe: recipe
  end

  def new(conn, _params) do
    changeset = Recipe.changeset(%Recipe{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"recipe" => recipe_params}) do
    case current_user(conn) |> Recipes.create_recipe(recipe_params) do
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
        if recipe.remove_image, do: Recipes.delete_image(recipe)        
        conn
        |> put_flash(:info, "La recette a bien été créée.")
        |> redirect(to: recipe_path(conn, :show, recipe))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  def delete(conn, _params) do
    {:ok, _recipe} = conn.assigns[:recipe] |> Recipes.delete
    conn
    |> put_flash(:notice, "La recette a bien été supprimé.")
    |> redirect(to: recipe_path(conn, :index))
  end

  ## Private
  defp put_recipe(conn, _) do
    recipe = Recipe
      |> preload(:user)
      |> Repo.get!(conn.params["id"])
    assign(conn, :recipe, recipe)
  end

  defp is_owner(conn, _) do
    recipe = conn.assigns[:recipe]
    if recipe.user.id != current_user(conn).id do
      conn
      |> put_flash(:error, "Vous ne pouvez pas modifier la recette de quelqu'un d'autre")
      |> redirect(to: recipe_path(conn, :index))
      |> halt()
    else
      conn
    end
  end
end