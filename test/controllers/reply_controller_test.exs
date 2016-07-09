defmodule Askcode.ReplyControllerTest do
  use Askcode.ConnCase

  alias Askcode.Reply
  @discussion_id 1
  @valid_attrs %{code: "some content", description: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, discussion_reply_path(conn, :index, @discussion_id)
    assert json_response(conn, 200) == []
  end

  test "shows chosen resource", %{conn: conn} do
    reply = Repo.insert! %Reply{}
    conn = get conn, discussion_reply_path(conn, :show, @discussion_id, reply)
    assert json_response(conn, 200) == %{"id" => reply.id,
      "description" => reply.description,
      "code" => reply.code}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, discussion_reply_path(conn, :show, @discussion_id, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, discussion_reply_path(conn, :create, @discussion_id), reply: @valid_attrs
    assert json_response(conn, 201)["id"]
    assert Repo.get_by(Reply, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, discussion_reply_path(conn, :create, @discussion_id), reply: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    reply = Repo.insert! %Reply{}
    conn = put conn, discussion_reply_path(conn, :update, @discussion_id, reply), reply: @valid_attrs
    assert json_response(conn, 200)["id"]
    assert Repo.get_by(Reply, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    reply = Repo.insert! %Reply{}
    conn = put conn, discussion_reply_path(conn, :update, @discussion_id, reply), reply: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    reply = Repo.insert! %Reply{}
    conn = delete conn, discussion_reply_path(conn, :delete, @discussion_id, reply)
    assert response(conn, 204)
    refute Repo.get(Reply, reply.id)
  end
end
