defmodule Portal.Door do
  @doc """
  Starts a door with a given `color`.

  The color is given so we can identify the door by color name instead of using
  a PID
  """
  def start_link(color) do
    Agent.start_link(fn -> [] end, name: color)
  end

  @doc """
  Gets a value from a door
  """
  def get(door) do
    Agent.get(door, fn list -> list end)
  end

  @doc """
  Pushes `value` into a door
  """
  def push(door, value) do
    Agent.update(door, fn list -> [value|list] end)
  end

  @doc """
  Pops a `value` from a `door`

  Returns `{:ok, value}` if there is a `value` or `:error` if the hole is empty
  """
  def pop(door) do
    Agent.get_and_update(door, fn
      []    -> {:error, []}
      [h|t] -> {{:ok, h}, t}
    end)
  end
end
