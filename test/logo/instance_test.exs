defmodule Logo.InstanceTest do
  use ExUnit.Case
  alias Logo.Instance

  setup do
    {:ok, pid} = Instance.start
    {:ok, pid: pid}
  end

  test "can start a logo instance", meta do
    assert is_pid(meta[:pid])
  end

  test "can set the color", meta do
    turtle = meta[:pid]
             |> Instance.color({255, 0, 0})
             |> Instance.get_turtle
    assert {255, 0, 0} = turtle.color
  end

  test "can put the pen down", meta do
    turtle = meta[:pid]
             |> Instance.pen_down
             |> Instance.get_turtle
    assert turtle.pen_down
  end

  test "can move forward", meta do
    turtle = meta[:pid]
             |> Instance.forward(400)
             |> Instance.get_turtle
    assert_in_delta(400, turtle.x, 0.000001)
  end

  test "can move to a particular position", meta do
    turtle = meta[:pid]
             |> Instance.move_to({500, 500})
             |> Instance.get_turtle
    assert 500 = turtle.x
    assert 500 = turtle.y
  end

  test "can rotate", meta do
    turtle = meta[:pid]
             |> Instance.right(90)
             |> Instance.get_turtle
    assert 90 = turtle.angle
    turtle = meta[:pid]
             |> Instance.right(360)
             |> Instance.get_turtle
    assert 90 = turtle.angle
    turtle = meta[:pid]
             |> Instance.left(20)
             |> Instance.get_turtle
    assert 70 = turtle.angle
  end

  test "converting degrees to radians" do
    assert (3 * :math.pi)/2 == Instance.radians(270)
  end

  test "walking at an angle", meta do
    turtle = meta[:pid]
             |> Instance.right(45)
             |> Instance.forward(:math.sqrt(2))
             |> Instance.get_turtle
    assert_in_delta(1, turtle.x, 0.000001)
    assert_in_delta(1, turtle.y, 0.000001)
  end

  test "pushing position", meta do
    turtle = meta[:pid]
             |> Instance.forward(1)
             |> Instance.pushpos
             |> Instance.forward(1)
             |> Instance.pushpos
             |> Instance.get_turtle
    assert [{2.0, 0.0}, {1.0, 0.0}] = turtle.positions
  end

  test "popping position", meta do
    turtle = meta[:pid]
             |> Instance.forward(1)
             |> Instance.pushpos
             |> Instance.forward(1)
             |> Instance.poppos
             |> Instance.get_turtle
    assert [] = turtle.positions
    assert_in_delta(1, turtle.x, 0.000001)
    assert_in_delta(0, turtle.y, 0.000001)
  end
end
