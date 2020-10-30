defmodule SimpleMongoApp.Article do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  schema "title" do
    field :contents, :string

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    cast(user, params, [:name, :age])
  end
end
