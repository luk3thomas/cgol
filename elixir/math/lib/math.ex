defmodule Math do
  def fib(n) when n < 0, do: 0
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n), do: fib(n-2) + fib(n-1)

  def sum([]), do: 0
  def sum([head|tail]), do: head + sum(tail)

  def map([], _func), do: []
  def map([h|t], func) do
    [func.(h) | map(t, func)]
  end
end
