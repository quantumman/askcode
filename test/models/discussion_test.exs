defmodule Askcode.DiscussionTest do
  use Askcode.ModelCase

  alias Askcode.Discussion

  @valid_attrs %{code: "some content", description: "some content", subject: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Discussion.changeset(%Discussion{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Discussion.changeset(%Discussion{}, @invalid_attrs)
    refute changeset.valid?
  end
end
