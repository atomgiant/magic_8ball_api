defmodule Magic8ball.Response do
  import Plug.Conn

  def error(conn, message) do
    conn
    |> put_json(%{ "error" => message }, 500)
  end

  def not_found(conn) do
    conn
    |> put_json(%{ "error" => "Not found" }, 404)
  end

  def too_many_requests(conn) do
    conn
    |> put_json(%{ "error" => "Too many requests" }, 429)
  end

  def unauthorized(conn) do
    conn
    |> put_json(%{ "error" => "Unauthorized" }, 401)
  end

  def put_json(conn, rsp, status \\ 200) do
    # IO.inspect conn
    # IO.inspect rsp
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Poison.encode!(rsp))
  end

end
