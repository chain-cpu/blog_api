defmodule SntxGraph.PostResolver do
  import SntxWeb.Payload

  alias Sntx.{Repo, Guardian, UserMailer}
  alias Sntx.Models.Blog.{Post}
  alias Sntx.Models.Blog

  def create(%{input: input}, %{context: ctx}) do
    with {:ok, post} <- Blog.create_post(%{title: input.title, body: input.body, author: ctx.user.id}) do
      {:ok, post}
    else
      error ->
        IO.puts("error")
        mutation_error_payload(error)
    end
  end

  def get(%{id: id}, _) do
    post = Blog.get_post!(id)
    {:ok, Repo.get(Post, id)}
  end

  def get_all(_, _), do: {:ok, Blog.list_posts()}

  def get_current(_, %{context: ctx}), do: {:ok, Repo.get(Account, ctx.user.id)}

  def update(%{input: input}, %{context: ctx}) do
    post = Repo.get(Post, input.id)
    if post.author === ctx.user.id do
      case Blog.update_post(post, %{title: input.title, body: input.body}) do
        {:ok, user} -> {:ok, user}
        error -> mutation_error_payload(error)
      end
    else
      {:error, "not owner of post"}
    end
  end

  def delete(%{id: id}, %{context: ctx} ) do
    post = Repo.get(Post, id)
    if post.author === ctx.user.id do
      case Blog.delete_post(post, %{id: id}) do
        {:ok, user} -> {:ok, user}
        error -> mutation_error_payload(error)
      end
    else
      {:error, "not owner of post"}
    end
  end

end
