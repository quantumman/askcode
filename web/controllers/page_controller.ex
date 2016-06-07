defmodule Askcode.PageController do
  use Askcode.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
