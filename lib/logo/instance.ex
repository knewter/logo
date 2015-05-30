defmodule Logo.Instance do
  use GenServer
  alias __MODULE__

  defmodule Turtle do
    defstruct [
      color: nil,
      pen_down: false,
      x: 0,
      y: 0,
      angle: 0
    ]
  end

  # Public API
  def start do
    GenServer.start(Instance, %Turtle{}, [])
  end

  def color(pid, {r, g, b}) do
    :ok = GenServer.cast(pid, {:color, {r, g, b}})
    pid
  end

  def pen_down(pid) do
    :ok = GenServer.cast(pid, :pen_down)
    pid
  end

  def forward(pid, amount) do
    :ok = GenServer.cast(pid, {:forward, amount})
    pid
  end

  def right(pid, angle) do
    :ok = GenServer.cast(pid, {:angle_delta, angle})
    pid
  end

  def left(pid, angle) do
    :ok = GenServer.cast(pid, {:angle_delta, -1 * angle})
    pid
  end

  def get_turtle(pid) do
    GenServer.call(pid, :get_turtle)
  end

  # Server callbacks
  def init(turtle) do
    {:ok, turtle}
  end

  def handle_cast({:color, {r, g, b}}, turtle) do
    {:noreply, %Turtle{turtle|color: {r, g, b}}}
  end
  def handle_cast(:pen_down, turtle) do
    {:noreply, %Turtle{turtle|pen_down: true}}
  end
  def handle_cast({:forward, amount}, turtle) do
    delta_x = amount * :math.cos(radians(turtle.angle))
    delta_y = amount * :math.sin(radians(turtle.angle))
    {:noreply, %Turtle{turtle|x: turtle.x + delta_x, y: turtle.y + delta_y}}
  end
  def handle_cast({:angle_delta, angle}, turtle) do
    angle = rem(360 + turtle.angle + angle, 360)
    {:noreply, %Turtle{turtle|angle: angle}}
  end

  def handle_call(:get_turtle, _from, turtle) do
    {:reply, turtle, turtle}
  end

  def radians(degrees) do
    degrees * (:math.pi/180)
  end
end
