# Heavily inspired by: https://github.com/rbishop/plug_basic_auth
defmodule Magic8ball.Authenticator do
  import Plug.Conn

  @api_keys %{"foo" => "123", "bar" => "456"}

  def init(options), do: options

  def call(conn, opts) do
    if except_match?(conn, opts[:except]) do
      conn
    else
      authenticate(conn)
    end
  end

  def authenticate(conn) do
    {user, pwd} = get_credentials(conn)
    if verify_user(user, pwd) do
      conn
    else
      conn
      |> Magic8ball.Response.unauthorized
      |> halt
    end
  end

  defp verify_user(nil, nil), do: false
  defp verify_user(user, pwd), do: @api_keys[user] == pwd

  defp except_match?(%Plug.Conn{}, nil), do: false
  defp except_match?(%Plug.Conn{path_info: path_info, script_name: script_name}, except_paths) do
    Enum.any?(except_paths, fn(e) ->
      Enum.join(script_name ++ path_info, "/") == Enum.join(script_name ++ [e], "/")
    end)
  end

  defp get_credentials(conn) do
    conn
    |> get_auth_header
    |> parse_auth
  end

  defp get_auth_header(conn) do
    get_req_header(conn, "authorization")
  end

  defp parse_auth(["Basic " <> encoded_creds | _]) do
    {:ok, decoded_creds} = Base.decode64(encoded_creds)
    [user, pwd] = String.split(decoded_creds, ":", parts: 2)
    {user, pwd}
  end
  defp parse_auth(_), do: {nil, nil}
end
