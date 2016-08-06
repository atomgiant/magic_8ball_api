defmodule Magic8ball.API do
  use Plug.Router

  alias Magic8ball.Answers
  alias Magic8ball.Authenticator
  alias Magic8ball.Response

  plug :match
  plug Authenticator, except: ["shake"]
  plug Plug.Parsers, parsers: [:urlencoded, :json],
                   pass:  ["text/*"],
                   json_decoder: Poison
  plug :dispatch

  get "/shake" do
    conn
    |> Response.put_json(%{answer: Enum.random(Answers.answers)})
  end

  get "/answers" do
    rsp = build_answers(conn.params["page"], conn.params["per_page"])
    conn
    |> Response.put_json(rsp)
  end

  post "/answers" do
    case Answers.add(conn.params["answer"]) do
      true ->
        conn
        |> Response.put_json(%{answers: Answers.answers})
      false ->
        conn
        |> Response.error("Unable to add the answer")
    end
  end

  put "/answers" do
    case Answers.update(conn.params["answer"], conn.params["value"]) do
      true ->
        conn
        |> Response.put_json(%{answers: Answers.answers})
      false ->
        conn
        |> Response.error("Unable to update the answer")
    end
  end

  delete "/answers" do
    case Answers.delete(conn.params["answer"]) do
      true ->
        conn
        |> Response.put_json(%{answers: Answers.answers})
      false ->
        conn
        |> Response.error("Unable to delete the answer")
    end
  end

  get "/boom", do: raise "api.boom"
  match _, do: Response.not_found(conn)

  defp build_answers(nil, per_page), do: build_answers(1, per_page)
  defp build_answers(page, nil), do: build_answers(page, 10)
  defp build_answers(page, per_page) do
    page = if is_bitstring(page), do: String.to_integer(page), else: page
    per_page = if is_bitstring(per_page), do: String.to_integer(per_page), else: per_page

    answers = Answers.answers
    result = %{
      answers: Enum.slice(answers, ((page-1)*per_page..(page*per_page)-1)),
      total: Enum.count(answers),
      page: page,
    }
    result
  end

end
