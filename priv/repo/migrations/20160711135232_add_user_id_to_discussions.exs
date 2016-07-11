defmodule Askcode.Repo.Migrations.AddUserIdToDiscussions do
  use Ecto.Migration

  def change do
    alter table(:discussions) do
      add :user_id, references(:users, on_delete: :nothing)
    end
  end
end
