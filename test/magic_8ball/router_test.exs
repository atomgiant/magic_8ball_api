defmodule RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Magic8ball.Router

  @opts Router.init([])

  test "returns hello world" do
    conn = conn(:get, "/")
    |> Router.call(@opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body =~ ~r/world/
  end

  test "error handler" do
    assert_raise RuntimeError, fn ->
      conn = conn(:get, "/boom")
      |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 500
      assert conn.resp_body =~ ~r/something bad happened/i
    end

  end
end
