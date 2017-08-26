defmodule Yummy.Recipes do
  import Ecto.Query, warn: false
  import Ecto.Changeset, only: [put_assoc: 3]  
  alias Yummy.Recipes.{Recipe, Comment}
  alias Yummy.{Repo, ImageUploader}

  def search_recipes(query, keywords) do
    from r in query,
    where: ilike(r.title, ^("%#{keywords}%")) or
           ilike(r.content, ^("%#{keywords}%"))
  end

  def create_recipe(user, attrs) do
    %Recipe{}
    |> Recipe.changeset(attrs)
    |> put_assoc(:user, user)
    |> Repo.insert()
  end

  def update_recipe(%Recipe{} = recipe, attrs) do
    recipe
    |> Recipe.changeset(attrs)
    |> Repo.update()
  end

  def delete(%Recipe{} = recipe) do
    {:ok, recipe} = recipe |> Repo.delete()
    delete_image_files(recipe)
    {:ok, recipe}
  end

  def delete_image(%Recipe{} = recipe) do
    recipe
    |> delete_image_files
    |> Recipe.changeset(%{image_url: nil})
    |> Repo.update()
  end

  defp delete_image_files(%Recipe{image_url: nil} = recipe), do: recipe
  defp delete_image_files(%Recipe{} = recipe) do
    path = ImageUploader.url({recipe.image_url, recipe})
      |> String.split("?")
      |> List.first 
    :ok = ImageUploader.delete({path, recipe})
    recipe
  end


  def create_comment(user, recipe, attrs) do
    %Comment{}
    |> Comment.changeset(attrs)
    |> put_assoc(:user, user)
    |> put_assoc(:recipe, recipe)
    |> Repo.insert()
  end
end
