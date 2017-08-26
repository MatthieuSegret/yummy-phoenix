defmodule YummyWeb.CommentController do
  use YummyWeb, :controller

  alias Yummy.Recipes
  alias Yummy.Recipes.Recipe

  plug Coherence.RequireLogin

  def create(conn, %{"comment" => comment_params, "recipe_id" => recipe_id }) do
    recipe = Recipe
      |> Repo.get!(recipe_id)
      |> Repo.preload([{:comments, :user}, :user])

    case current_user(conn) |> Recipes.create_comment(recipe, comment_params) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Le commentaire à bien été posté.")
        |> redirect(to: "#{recipe_path(conn, :show, recipe)}#comments")
      {:error, %Ecto.Changeset{} = comment_changeset} ->
        render(conn, YummyWeb.RecipeView, "show.html", recipe: recipe, comment_changeset: comment_changeset)
    end
  end
end