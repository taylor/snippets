#!/usr/bin/env elixir

# Example of sending and receiving messages with a spawned Process in Elixir
# Run with elixir thefilename.exs

them = spawn fn ->
  receive do
    {foo, pid} ->
      IO.puts "Someone with #{inspect(pid)} gave me #{inspect(foo)}"
      IO.puts "I am going to tell them thanks"
      pid |> send {"Thank's person with #{inspect(pid)} for giving me #{inspect(foo)}", self }
  end
end

IO.puts "Sending cheese to them via #{inspect(them)}"
them |> send {"cheese", self }

receive do
  {foo, pid } ->
    IO.puts "Someone from #{inspect(pid)} sent me the message: #{foo}"
end
