defmodule MathTest do
  use ExUnit.Case

  test "fib" do
    assert Math.fib(-10) ==  0
    assert Math.fib(  0) ==  0
    assert Math.fib(  1) ==  1
    assert Math.fib(  2) ==  1
    assert Math.fib(  3) ==  2
    assert Math.fib(  4) ==  3
    assert Math.fib(  5) ==  5
    assert Math.fib(  6) ==  8
    assert Math.fib(  7) == 13
    assert Math.fib(  8) == 21
  end

  test "sum" do
    assert Math.sum([1,2,3]) == 6
  end

  test "map" do
    assert Math.map([1,2,3,4], fn x -> x * x end) == [1,4,9,16]
    assert Math.map([1,2,3,4], &(&1*&1))          == [1,4,9,16]
    assert [1,2,3,4]        |> Math.map(&(&1*&1)) == [1,4,9,16]
  end

  test "transform" do
    assert [1,2,3,4] |> Math.map(&(&1*&1)) |> Math.sum == 30
  end
end
