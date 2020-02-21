defmodule App.Pong do
    def start() do
        wait()
    end

    def wait() do
        receive do
            {pid, :ping} ->
            send(pid, {self(), :pong})
            IO.puts "Recebi um ping"
        end
        wait()
    end
end

# pid = spawn(App.Ping, :start, [])
# send(pid, {self(), :pong})