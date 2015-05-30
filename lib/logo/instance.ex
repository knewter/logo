defmodule Logo.Instance do
  use GenServer
  alias __MODULE__

  # Public API
  def start do
    GenServer.start(Instance, :ok, [])
  end

  # Server callbacks
  def init(:ok) do
    {:ok, []}
  end
end
