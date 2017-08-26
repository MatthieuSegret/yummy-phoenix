defmodule Yummy.Recipes.Recipe do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
  alias Yummy.Recipes.{Recipe, Comment}
  alias Yummy.Accounts.User

  @total_time_options ["10 min", "20 min", "30 min", "45 min", "1h", "+1h"]
  @level_options ["Très facile", "Facile", "Moyenne", "Difficile"]
  @budget_options ["Bon marché", "Moyen", "Assez cher"]

  schema "recipes" do
    field :content, :string
    field :title, :string
    field :total_time, :string
    field :level, :string
    field :budget, :string
    field :image_url, Yummy.ImageUploader.Type
    field :remove_image, :boolean, virtual: true
    field :uuid, :string
    belongs_to :user, User
    has_many :comments, Comment

    timestamps()
  end

  @doc false
  def changeset(%Recipe{} = recipe, attrs \\ %{}) do
    recipe
    |> cast(attrs, [:title, :content, :total_time, :level, :budget, :uuid, :remove_image])
    |> check_uuid
    |> cast_attachments(attrs, [:image_url])
    |> validate_required([:title, :content, :total_time, :level, :budget, :uuid])
    |> validate_inclusion(:total_time, @total_time_options)
    |> validate_inclusion(:level, @level_options)
    |> validate_inclusion(:budget, @budget_options)
  end

  def total_time_options, do: @total_time_options
  def level_options, do: @level_options
  def budget_options, do: @budget_options

  defp check_uuid(changeset) do
    if get_field(changeset, :uuid) == nil do
      force_change(changeset, :uuid, Ecto.UUID.generate())
    else
      changeset
    end
  end
end
