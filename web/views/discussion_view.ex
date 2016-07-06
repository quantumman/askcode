defmodule Askcode.DiscussionView do
  use Askcode.Web, :view

  def render("index.json", %{discussions: discussions}) do
    render_many(discussions, Askcode.DiscussionView, "discussion.json")
  end

  def render("show.json", %{discussion: discussion}) do
    render_one(discussion, Askcode.DiscussionView, "discussion.json")
  end

  def render("discussion.json", %{discussion: discussion}) do
    %{id: discussion.id,
      subject: discussion.subject,
      description: discussion.description,
      code: discussion.code
      replies: Askcode.ReplyView.render("index.json", replies: discussion.replies)}
  end
end
