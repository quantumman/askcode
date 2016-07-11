defmodule Askcode.DiscussionControllerTest do
  use Askcode.ConnCase

  alias Askcode.Discussion
  @valid_attrs %{code: "some content", description: "some content", subject: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, discussion_path(conn, :index)
    assert json_response(conn, 200) == []
  end

  test "shows chosen resource", %{conn: conn} do
    discussion = Repo.insert! %Discussion{}
    conn = get conn, discussion_path(conn, :show, discussion)
    assert json_response(conn, 200) == %{"id" => discussion.id,
      "subject" => discussion.subject,
      "description" => discussion.description,
      "code" => discussion.code}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, discussion_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    # TODO: Test create action

    # conn = post conn, discussion_path(conn, :create), discussion: @valid_attrs
    # assert json_response(conn, 201)["id"]
    # assert Repo.get_by(Discussion, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, discussion_path(conn, :create), discussion: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    discussion = Repo.insert! %Discussion{}
    conn = put conn, discussion_path(conn, :update, discussion), discussion: @valid_attrs
    assert json_response(conn, 200)["id"]
    assert Repo.get_by(Discussion, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    discussion = Repo.insert! %Discussion{}
    conn = put conn, discussion_path(conn, :update, discussion), discussion: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    discussion = Repo.insert! %Discussion{}
    conn = delete conn, discussion_path(conn, :delete, discussion)
    assert response(conn, 204)
    refute Repo.get(Discussion, discussion.id)
  end
end
