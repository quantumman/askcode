defmodule Askcode.ReplyController do
  use Askcode.Web, :controller

  alias Askcode.Reply

  def index(conn, _params) do
    replies = Repo.all(Reply)
    render(conn, "index.json", replies: replies)
  end

  def create(conn, %{"discussion_id" => discussion_id, "reply" => reply_params}) do
    changeset = Reply.changeset(%Reply{}, reply_params)

    case Repo.insert(changeset) do
      {:ok, reply} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", discussion_reply_path(conn, :show, discussion_id, reply))
        |> render("show.json", reply: reply)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Askcode.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    reply = Repo.get!(Reply, id)
    render(conn, "show.json", reply: reply)
  end

  def update(conn, %{"id" => id, "reply" => reply_params}) do
    reply = Repo.get!(Reply, id)
    changeset = Reply.changeset(reply, reply_params)

    case Repo.update(changeset) do
      {:ok, reply} ->
        render(conn, "show.json", reply: reply)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Askcode.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    reply = Repo.get!(Reply, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(reply)

    send_resp(conn, :no_content, "")
  end
end
