defmodule Askcode.Discussion do
  use Askcode.Web, :model

  schema "discussions" do
    field :subject, :string
    field :description, :string
    field :code, :string

    has_many :replies, Askcode.Reply

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:subject, :description, :code])
    |> validate_required([:subject, :description, :code])
  end
end
