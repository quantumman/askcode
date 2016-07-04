defmodule Askcode.ReplyView do
  use Askcode.Web, :view

  def render("index.json", %{replies: replies}) do
    render_many(replies, Askcode.ReplyView, "reply.json")
  end

  def render("show.json", %{reply: reply}) do
    render_one(reply, Askcode.ReplyView, "reply.json")
  end

  def render("reply.json", %{reply: reply}) do
    %{id: reply.id,
      description: reply.description,
      code: reply.code}
  end
end
