# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Askcode.Repo.insert!(%Askcode.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

require Forge

generate = fn _ ->
  discussion = Forge.discussion
  {:ok, user} = Forge.saved_user Askcode.Repo
  Ecto.build_assoc(user, :discussions, discussion)
  |> Askcode.Repo.insert

  users = Forge.saved_user_list(Askcode.Repo, 10) |> Enum.map(&elem(&1, 1))
  replies = users
  |> Enum.map(&Ecto.build_assoc(&1, :replies, Forge.reply))
  |> Enum.map(&Ecto.build_assoc(discussion, :replies, &1))
  |> Enum.each(&Askcode.Repo.insert(&1)) # FIXME Insert insdie transaction
end


1..10
|> Enum.each(generate)
