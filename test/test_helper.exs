ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Askcode.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Askcode.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Askcode.Repo)

