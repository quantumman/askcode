defmodule Askcode.SessionController do
  use Askcode.Web, :controller

  plug :scrub_params, "session" when action in [:create]

  def create(conn, %{"session" => session_params}) do
    case Askcode.Session.authenticate(session_params) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = user |> Guardian.encode_and_sign(:token)

        conn
        |> put_status(:created)
        |> render("show.json", jwt: jwt, user: user)

      :error ->
        conn
        |> put_status(:unauthorized)
        |> render("error.json")
    end
  end


  def unauthenticated(conn, _params) do
    conn
    |> put_status(:unauthorized)
    |> render(Askcode.ErrorView, "401.json")
  end
end
