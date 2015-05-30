defmodule Logo.InstanceTest do
  use ExUnit.Case

  test "can start a logo instance" do
    assert {:ok, _pid} = Logo.Instance.start
  end
end
