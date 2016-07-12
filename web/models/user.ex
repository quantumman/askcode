defmodule Askcode.User do
  use Askcode.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :avatar, :string
    field :encrypted_password, :string

    has_many :replies, Askcode.Reply
    has_many :discussions, Askcode.Discussion

    timestamps
  end

  @required_fields ~w(email)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
