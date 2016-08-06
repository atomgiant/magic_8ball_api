defmodule APITest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Magic8ball.API

  @opts API.init([])

  test "GET /shake" do
    conn = conn(:get, "/shake")
    |> API.call(@opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    rsp = Poison.decode!(conn.resp_body)
    assert %{"answer"=> _a} = rsp
  end

  test "GET /answers unauthorized" do
    conn = conn(:get, "/answers")
    |> API.call(@opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 401
    rsp = Poison.decode!(conn.resp_body)
    assert %{"error" => "Unauthorized"} = rsp
  end

  test "GET /answers" do
    conn = conn(:get, "/answers")
    |> put_auth("foo", "123")
    |> API.call(@opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    rsp = Poison.decode!(conn.resp_body)
    assert %{"answers"=> _answers} = rsp
  end

  test "GET /answers paginated" do
    conn = conn(:get, "/answers?page=1")
    |> put_auth("foo", "123")
    |> API.call(@opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    rsp = Poison.decode!(conn.resp_body)
    answers = Magic8ball.Answers.answers
    assert %{"answers"=> _answers, "page" => 1, "total" => total} = rsp
    assert 10 == Enum.count(rsp["answers"])
    assert Enum.count(answers) == total

    conn = conn(:get, "/answers?page=2&per_page=5")
    |> put_auth("foo", "123")
    |> API.call(@opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    rsp = Poison.decode!(conn.resp_body)
    answers = Magic8ball.Answers.answers
    assert %{"answers"=> _answers, "page" => 2, "total" => total} = rsp
    assert Enum.slice(answers, (5..9)) == rsp["answers"]
    assert Enum.count(answers) == total
  end

  test "POST /answers" do
    conn = conn(:post, "/answers?answer=Definitely")
    |> put_auth("foo", "123")
    |> API.call(@opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    rsp = Poison.decode!(conn.resp_body)
    assert %{"answers"=> answers} = rsp
    assert Enum.member?(answers, "Definitely")
  end

  test "PUT /answers" do
    Magic8ball.Answers.add("Definitely")
    conn = conn(:put, "/answers?answer=Definitely&value=Most Definitely")
    |> put_auth("foo", "123")
    |> API.call(@opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    rsp = Poison.decode!(conn.resp_body)
    assert %{"answers"=> answers} = rsp
    assert Enum.member?(answers, "Most Definitely")
  end

  test "DELETE /answers" do
    Magic8ball.Answers.add("Delete Me")
    conn = conn(:delete, "/answers?answer=Delete Me")
    |> put_auth("foo", "123")
    |> API.call(@opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    rsp = Poison.decode!(conn.resp_body)
    assert %{"answers"=> answers} = rsp
    assert !Enum.member?(answers, "Delete Me")
  end

  def put_auth(conn, user, pass) do
    auth_header = "Basic " <> Base.encode64("#{user}:#{pass}")
    conn
    |> put_req_header("authorization", auth_header)
  end
end
