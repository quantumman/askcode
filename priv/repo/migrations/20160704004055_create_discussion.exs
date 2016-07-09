defmodule Askcode.Repo.Migrations.CreateDiscussion do
  use Ecto.Migration

  def change do
    create table(:discussions) do
      add :subject, :string
      add :description, :string
      add :code, :string

      timestamps
    end
  end
end
