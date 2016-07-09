defmodule Askcode.Reply do
  use Askcode.Web, :model

  schema "replies" do
    field :description, :string
    field :code, :string

    belongs_to :user, Askcode.User
    belongs_to :discussion, Askcode.Discussion

    timestamps
  end

  @required_fields ~w(description code)
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
