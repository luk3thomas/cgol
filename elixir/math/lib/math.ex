defmodule Math do
  def fib(n) when n < 0, do: 0
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n), do: fib(n-2) + fib(n-1)
end
