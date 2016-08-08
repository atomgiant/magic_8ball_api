defmodule Magic8ball.Router do
  use Plug.Router
  use Plug.ErrorHandler

  plug Plug.Logger, log: :debug
  plug :match
  plug :dispatch


  get "/", do: Magic8ball.Response.put_json(conn, %{ message:  "Hello world" })
  get "/boom", do: raise "boom"
  forward "/api/v1", to: Magic8ball.API.V1
  forward "/api/v2", to: Magic8ball.API
  forward "/api", to: Magic8ball.API

  match _, do: Magic8ball.Response.not_found(conn)

  defp handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack} = error) do
    IO.inspect error
    Magic8ball.Response.error(conn, "Something bad happened")
  end
end
