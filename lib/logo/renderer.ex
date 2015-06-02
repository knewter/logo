defmodule Logo.Renderer do
  alias Logo.Instance
  @side 5.0

  def render(canvas, instance) do
    brush = :wxBrush.new({0, 0, 0, 255})
    turtle = Instance.get_turtle(instance)
    draw_shapes(canvas, turtle.shapes)
  end

  def draw_shapes(canvas, [head|rest]) do
    draw_shape(canvas, head)
    draw_shapes(canvas, rest)
  end
  def draw_shapes(_canvas, []), do: :ok

  def draw_shape(canvas, {:line, {x1, y1}, {x2, y2}}) do
    pen = :wxPen.new({255, 0, 0, 255})
    :wxGraphicsContext.setPen(canvas, pen)
    :wxGraphicsContext.drawLines(canvas, [{x1, y1}, {x2, y2}])
    :ok
  end

  def draw_square(canvas, x, y, brush) do
    :wxGraphicsContext.setBrush(canvas, brush)
    true_x = @side * x
    true_y = @side * y
    :wxGraphicsContext.drawRectangle(canvas, true_x, true_y, @side, @side)
    :ok
  end

  def int(float) when is_integer(float), do: float
  def int(float) do
    Float.floor(float) |> trunc
  end
end
