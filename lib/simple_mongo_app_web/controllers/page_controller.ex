defmodule SimpleMongoAppWeb.PageController do
  use SimpleMongoAppWeb, :controller

  defp analyse_params( params ) do
    user_input = params[ "page" ]
    case user_input do
      nil -> nil
      other -> other[ "name" ]
    end
  end

  def index(conn, params) do
    render conn, "index.html"
    status = analyse_params params
if status == nil do
  IO.puts "***"
  IO.puts "status is nil"
else
  IO.puts "$$$"
  IO.puts "status is #{status}"
end
    conn
  end

end
