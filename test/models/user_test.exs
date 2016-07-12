defmodule Askcode.UserTest do
  use Askcode.ModelCase

  alias Askcode.User

  @valid_attrs %{password: "xxxsdfsdf", email: Faker.Internet.email}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
