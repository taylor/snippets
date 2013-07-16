them = spawn fn ->
  receive do
    {foo, pid} ->
      IO.puts "Someone with #{inspect(pid)} gave me #{inspect(foo)}"
      IO.puts "I am going to tell them thanks"
      pid <- {"Thank's person with #{inspect(pid)} for giving me #{inspect(foo)}", self }
  end
end

IO.puts "Sending cheese to them via #{inspect(them)}"
them <- {"cheese", self }

receive do
  {foo, pid } ->
    IO.puts "Someone from #{inspect(pid)} sent me the message: #{foo}"
end
