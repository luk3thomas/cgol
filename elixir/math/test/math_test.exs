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
end
