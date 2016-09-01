defmodule Askcode.User do
  use Askcode.Web, :model

  @derive {Poison.Encoder, only: [:name, :avatar, :email]}
  schema "users" do
    field :name, :string
    field :email, :string
    field :avatar, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true

    has_many :replies, Askcode.Reply
    has_many :discussions, Askcode.Discussion

    timestamps
  end

  @required_fields ~w(email password)
  @optional_fields ~w(encrypted_password)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :invalid) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password, message: "Password does not match")
    |> unique_constraint(:email, message: "Email already exists")
  end
end
