defmodule Logo.Instance do
  use GenServer
  alias __MODULE__

  defmodule Turtle do
    defstruct [
      color: nil,
      pen_down: false,
      x: 0,
      y: 0,
      angle: 0,
      shapes: [],
      positions: []
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

  def move_to(pid, {x, y}) do
    :ok = GenServer.cast(pid, {:move_to, {x, y}})
    pid
  end

  def pushpos(pid) do
    GenServer.cast(pid, :pushpos)
    pid
  end

  def poppos(pid) do
    GenServer.cast(pid, :poppos)
    pid
  end

  def get_turtle(pid) do
    GenServer.call(pid, :get_turtle)
  end

  # Server callbacks
  def init(state) do
    {:ok, state}
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
    shapes = turtle.shapes
    if(turtle.pen_down) do
      shapes = [{:line, {turtle.x, turtle.y}, {turtle.x + delta_x, turtle.y + delta_y}}|shapes]
    end
    {:noreply, %Turtle{turtle|x: turtle.x + delta_x, y: turtle.y + delta_y, shapes: shapes}}
  end
  def handle_cast({:angle_delta, angle}, turtle) do
    angle = rem(360 + turtle.angle + angle, 360)
    {:noreply, %Turtle{turtle|angle: angle}}
  end
  def handle_cast({:move_to, {x, y}}, turtle) do
    {:noreply, %Turtle{turtle|x: x, y: y}}
  end
  def handle_cast({:move_to, {x, y}}, turtle) do
    {:noreply, %Turtle{turtle|x: x, y: y}}
  end
  def handle_cast(:pushpos, turtle) do
    {:noreply, %Turtle{turtle|positions: [{turtle.x, turtle.y}|turtle.positions]}}
  end
  def handle_cast(:poppos, turtle=%Turtle{positions: [{x, y}|positions]}) do
    {:noreply, %Turtle{turtle|x: x, y: y, positions: positions}}
  end

  def handle_call(:get_turtle, _from, turtle) do
    {:reply, turtle, turtle}
  end

  def radians(degrees) do
    degrees * (:math.pi/180)
  end
end
