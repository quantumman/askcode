defmodule Askcode.Repo.Migrations.AddEmailToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :email, :string
    end
    create index(:users, [:email], unique: true)
  end
end
