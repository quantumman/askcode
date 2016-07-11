defmodule Askcode.DiscussionController do
  use Askcode.Web, :controller

  alias Askcode.Discussion

  def index(conn, _params) do
    discussions =
      Repo.all(Discussion)
      |> Repo.preload([:replies, :creator])
    render(conn, "index.json", discussions: discussions)
  end

  def create(conn, %{"discussion" => discussion_params}) do
    # TODO: Save with created user
    changeset = Discussion.changeset(%Discussion{}, discussion_params)

    case Repo.insert(changeset) do
      {:ok, discussion} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", discussion_path(conn, :show, discussion))
        |> render("new.json", discussion: discussion)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Askcode.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    discussion =
      Repo.get!(Discussion, id)
      |> Repo.preload([:replies, :creator])
    render(conn, "show.json", discussion: discussion)
  end

  def update(conn, %{"id" => id, "discussion" => discussion_params}) do
    discussion = Repo.get!(Discussion, id) |> Repo.preload([:replies, :creator])
    changeset = Discussion.changeset(discussion, discussion_params)

    case Repo.update(changeset) do
      {:ok, discussion} ->
        render(conn, "show.json", discussion: discussion)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Askcode.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    discussion = Repo.get!(Discussion, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(discussion)

    send_resp(conn, :no_content, "")
  end
end
