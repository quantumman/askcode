defmodule Askcode.DiscussionView do
  use Askcode.Web, :view

  alias Askcode.ReplyView
  alias Askcode.UserView

  def render("index.json", %{discussions: discussions}) do
    render_many(discussions, Askcode.DiscussionView, "discussion.json")
  end

  def render("show.json", %{discussion: discussion}) do
    render_one(discussion, Askcode.DiscussionView, "discussion.json")
    |> Map.put_new(:replies, ReplyView.render("index.json", replies: discussion.replies))
  end

  def render("new.json", %{discussion: discussion}) do
    render_one(discussion, Askcode.DiscussionView, "discussion.json")
  end

  def render("discussion.json", %{discussion: discussion}) do
    %{id: discussion.id,
      subject: discussion.subject,
      description: discussion.description,
      code: discussion.code,
      creator: UserView.render("show.json", user: discussion.creator)
    }
  end
end
