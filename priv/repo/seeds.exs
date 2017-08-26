# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Yummy.Repo.insert!(%Yummy.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Yummy.Repo.delete_all Yummy.Accounts.User

Yummy.Accounts.User.changeset(%Yummy.Accounts.User{}, %{name: "jose", email: "jose@yummy.com", password: "12341234", password_confirmation: "12341234"})
|> Yummy.Repo.insert!
|> Coherence.ControllerHelpers.confirm!