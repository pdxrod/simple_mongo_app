defmodule SimpleMongoAppWeb.ConnCase do

  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ConnTest
      import SimpleMongoAppWeb.Router.Helpers
      @endpoint SimpleMongoAppWeb.Endpoint
    end
  end

  setup tags do
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end

end
