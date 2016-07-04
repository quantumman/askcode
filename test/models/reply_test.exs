defmodule Askcode.ReplyTest do
  use Askcode.ModelCase

  alias Askcode.Reply

  @valid_attrs %{code: "some content", description: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Reply.changeset(%Reply{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Reply.changeset(%Reply{}, @invalid_attrs)
    refute changeset.valid?
  end
end
