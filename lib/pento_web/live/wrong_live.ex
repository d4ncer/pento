defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, message: "Make a guess:", time: time())}
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
      <%= for n <- 1..10 do %>
        <.link href="#" phx-click="guess" phx-value-number={n}><%= n %></.link>
      <% end %>
    </h2>
    end
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    message = "Your guess: #{guess}. Wrong, guess again."
    score = socket.assigns.score - 1
    new_time = time()

    {
      :noreply,
      assign(socket, message: message, score: score, time: new_time)
    }
  end
end
