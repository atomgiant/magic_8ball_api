defmodule Magic8ball do
  use Application
  import Supervisor.Spec

  # Start and supervise Cowboy
  def start(_type, _args) do
    port = Application.get_env(:magic_8ball, :cowboy_port, 8080)

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Magic8ball.Router, [], port: port),
      worker(Magic8ball.Answers, [], restart: :permanent),
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
