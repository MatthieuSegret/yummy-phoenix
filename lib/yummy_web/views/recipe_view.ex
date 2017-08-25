defmodule YummyWeb.RecipeView do
  use YummyWeb, :view
  alias Yummy.Recipes.Recipe

  def description(text) do
    text
    |> truncate(length: 180)
    |> String.replace(~r/\r|\n|\t/, " ")
    |> String.replace(~r/#|\*/, "")
  end

  def markdown(text) do
    text
    |> Earmark.as_html!
    |> raw
  end

  defp truncate(text, length: length) do
    text
    |> String.slice(1..length)
    |> String.replace(~r/\s(.)*$/, "...")
  end
end
