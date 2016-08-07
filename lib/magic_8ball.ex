defmodule Magic8ball do
  use Application
  import Supervisor.Spec

  # Start and supervise Cowboy
  def start(_type, _args) do
    cowboy_start = Application.get_env(:magic_8ball, :cowboy_start, true)
    cowboy_port = Application.get_env(:magic_8ball, :cowboy_port, 8080)

    children = [
      worker(Magic8ball.Answers, [], restart: :permanent),
    ]
    children = case cowboy_start do
      true -> children ++ [Plug.Adapters.Cowboy.child_spec(:http, Magic8ball.Router, [], port: cowboy_port)]
      false -> children
    end

    Supervisor.start_link(children, strategy: :one_for_one)
  end

end
