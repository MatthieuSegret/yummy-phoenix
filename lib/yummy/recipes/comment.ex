defmodule Yummy.Recipes.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Yummy.Recipes.{Comment, Recipe}
  alias Yummy.Accounts.User


  schema "comments" do
    field :body, :string
    belongs_to :recipe, Recipe
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs \\ %{}) do
    comment
    |> cast(attrs, [:body, :user_id, :recipe_id])
    |> validate_required([:body])
  end
end
