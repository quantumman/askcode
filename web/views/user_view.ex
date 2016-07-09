defmodule Askcode.UserView do
  use Askcode.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Askcode.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Askcode.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      avatar: user.avatar}
  end
end
