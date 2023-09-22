defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def base_state(socket) do
    winning_number = Enum.random(1..10)

    assign(socket,
      winning_number: winning_number,
      score: 0,
      win_p: false,
      message: "Make a guess:",
      time: time()
    )
  end

  def mount(_params, _session, socket) do
    {:ok, base_state(socket)}
  end

  def time() do
    DateTime.utc_now() |> DateTime.to_string()
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %> It's <%= @time %>
    </h2>
    <h2>
      <div class="my-4">
        <%= for n <- 1..10 do %>
          <button
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-full"
            href="#"
            phx-click="guess"
            phx-value-number={n}
          >
            <%= n %>
          </button>
        <% end %>
      </div>
    </h2>
    <%= if @win_p do %>
      <button
        class="bg-transparent mb-4 hover:bg-blue-500 text-blue-700 font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded"
        phx-click="reset-state"
      >
        Reset
      </button>
    <% end %>
    <pre>
    <%= @current_user.email %>
    <%= @session_id %>
    </pre>
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    win_p = socket.assigns.winning_number == guess |> String.to_integer()

    message =
      if win_p,
        do: "You guess of #{guess} was correct, you won!",
        else: "Your guess: #{guess}. Wrong, guess again."

    score = if win_p, do: socket.assigns.score + 1, else: socket.assigns.score - 1
    new_time = time()

    {
      :noreply,
      assign(socket, message: message, score: score, time: new_time, win_p: win_p)
    }
  end

  def handle_event("reset-state", _params, socket) do
    {
      :noreply,
      base_state(socket)
    }
  end
end
