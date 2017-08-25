defmodule Yummy.Recipes do
  import Ecto.Query, warn: false
  alias Yummy.Recipes.Recipe
  alias Yummy.Repo

  def search_recipes(keywords) do
    from r in Recipe,
    where: ilike(r.title, ^("%#{keywords}%")) or
           ilike(r.content, ^("%#{keywords}%"))
  end

  def create_recipe(attrs) do
    %Recipe{}
    |> Recipe.changeset(attrs)
    |> Repo.insert()
  end

  def update_recipe(%Recipe{} = recipe, attrs) do
    recipe
    |> Recipe.changeset(attrs)
    |> Repo.update()
  end
end
