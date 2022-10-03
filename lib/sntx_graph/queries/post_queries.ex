defmodule SntxGraph.PostQueries do
  use Absinthe.Schema.Notation

  alias SntxGraph.Middleware.Authorize
  alias SntxGraph.PostResolver

  object :post_queries do
    field :all_posts, non_null(list_of(:post_response)) do
      resolve(&PostResolver.get_all/2)
    end

    field :post, :post_response do
      arg :id, :id
      resolve(&PostResolver.get/2)
    end
  end
end
