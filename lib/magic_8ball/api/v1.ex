defmodule Magic8ball.API.V1 do
  use Plug.Router
  import Plug.Conn

  plug :match
  plug :dispatch

  @answers ["yes", "no", "maybe so"]

  get "/shake" do
    conn
    |> send_resp(200, Enum.random(@answers))
  end

  match _, do: send_resp(conn, 404, "Not found")
end
