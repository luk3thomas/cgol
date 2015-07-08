defmodule Math do
  def zero(0),                        do:  true
  def zero(0.0),                      do:  true
  def zero(n) when is_number(n),      do: false
  def zero(n) when not is_number(n),  do: false
end

ExUnit.start

defmodule MathTest do
  use ExUnit.Case

  test ".zero" do
    assert Math.zero(0)   == true
    assert Math.zero(0.0) == true
    assert Math.zero(100) == false
    assert Math.zero(-10) == false
    assert Math.zero("a") == false
  end
end
