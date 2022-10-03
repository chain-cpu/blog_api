defmodule SntxGraph.PostTypes do
  use Absinthe.Schema.Notation

  import AbsintheErrorPayload.Payload

  alias Sntx.Models.Blog.Post

  payload_object(:post_payload, :post_response)

  input_object :post_create_input do
    import_fields(:post)
  end

  input_object :post_update_input do
    field :id, :id
    field :title, :string
    field :body, :string
  end

  object :post_response do
    field :id, :id
    import_fields(:post)
  end

  object :post do
    field :title, :string
    field :body, :string
    field :author, :string
  end

end
