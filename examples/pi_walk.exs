# See http://www.jeffreythompson.org/blog/2012/01/03/random-pi-walk/
import Logo.Instance

pi =
  File.read!("./examples/digits_of_pi.txt")
  |> String.strip
  |> String.graphemes

defmodule PiWalk do
  import Logo.Instance

  def angle_for("0"), do: 0
  def angle_for("1"), do: 36
  def angle_for("2"), do: 72
  def angle_for("3"), do: 108
  def angle_for("4"), do: 144
  def angle_for("5"), do: 180
  def angle_for("6"), do: 216
  def angle_for("7"), do: 252
  def angle_for("8"), do: 288
  def angle_for("9"), do: 324

  def color_for("0"), do: {5, 0, 0}
  def color_for("1"), do: {155, 0, 0}
  def color_for("2"), do: {55, 0, 0}
  def color_for("3"), do: {5, 255, 0}
  def color_for("4"), do: {55, 155, 0}
  def color_for("5"), do: {5, 55, 0}
  def color_for("6"), do: {5, 255, 155}
  def color_for("7"), do: {5, 255, 55}
  def color_for("8"), do: {5, 0, 255}
  def color_for("9"), do: {5, 0, 155}

  def walk_distance, do: 20

  def walk(logo, digit) do
    logo
    |> right(angle_for(digit))
    |> color(color_for(digit))
    |> forward(walk_distance)
  end
end

{:ok, logo} = Logo.Instance.start

logo
|> pen_down
|> move_to({300, 300})

Enum.reduce(pi, logo, fn(digit, acc) ->
  PiWalk.walk(logo, digit)
end)

Logo.Window.start(logo)
