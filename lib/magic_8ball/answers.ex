defmodule Magic8ball.Answers do
  def start_link do
    Agent.start_link(fn ->
      [
        "It is certain",
        "It is decidedly so",
        "Without a doubt",
        "Yes definitely",
        "You may rely on it",
        "As I see it, yes",
        "Most likely",
        "Outlook good",
        "Yes",
        "Signs point to yes",
        "Reply hazy try again",
        "Ask again later",
        "Better not tell you now",
        "Cannot predict now",
        "Concentrate and ask again",
        "Do not count on it",
        "My reply is no",
        "My sources say no",
        "Outlook not so good",
        "Very doubtful",
      ]
    end, name: __MODULE__)
  end

  def answers do
    Agent.get(__MODULE__, fn answers ->
      answers
    end)
  end

  def add(answer) do
    Agent.get_and_update(__MODULE__, fn list ->
      {true, list ++ [answer]}
    end)
  end

  def update(answer, value) do
    Agent.get_and_update(__MODULE__, fn list ->
      index = Enum.find_index(list, fn(e) -> e == answer end)
      if index do
        {true, List.replace_at(list, index, value)}
      else
        {false, list}
      end
    end)
  end

  def delete(answer) do
    Agent.get_and_update(__MODULE__, fn list ->
      {true, List.delete(list, answer)}
    end)
  end
end
