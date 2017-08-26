defmodule Yummy.Recipes do
  import Ecto.Query, warn: false
  import Ecto.Changeset, only: [put_assoc: 3]  
  alias Yummy.Recipes.Recipe
  alias Yummy.Repo

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
end
