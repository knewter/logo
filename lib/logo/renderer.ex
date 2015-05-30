defmodule Logo.Renderer do
  @side 5.0

  def render(canvas, config) do
    brush = :wxBrush.new({0, 0, 0, 255})
    draw_square(canvas, 10, 10, brush)
  end

  def draw_square(canvas, x, y, brush) do
    :wxGraphicsContext.setBrush(canvas, brush)
    true_x = @side * x
    true_y = @side * y
    :wxGraphicsContext.drawRectangle(canvas, true_x, true_y, @side, @side)
    :ok
  end
end
