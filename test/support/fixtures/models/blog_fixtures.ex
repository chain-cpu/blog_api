defmodule Sntx.Models.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Sntx.Models.Blog` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        author: "some author",
        body: "some body",
        title: "some title"
      })
      |> Sntx.Models.Blog.create_post()

    post
  end
end
