defmodule Askcode.RegistrationController  do
  use Askcode.Web, :controller

  alias Askcode.{Repo, User}

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => user_params}) do
    changeset = Askcode.UserController.changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user, :token)

        conn
        |> put_status(:created)
        |> render(Askcode.SessionView, "show.json", jwt: jwt, user: user)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Askcode.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
