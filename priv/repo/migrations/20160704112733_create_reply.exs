defmodule Askcode.Repo.Migrations.CreateReply do
  use Ecto.Migration

  def change do
    create table(:replies) do
      add :description, :string
      add :code, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :discussion_id, references(:discussions, on_delete: :nothing)

      timestamps
    end

  end
end
