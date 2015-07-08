defmodule Conditionals do

  defmodule Case do

    def simple do
      case true do
        _ -> "simple"
      end
    end

    def number_names(n) do
      case n do
        0 -> "zero"
        1 -> "one"
        2 -> "two"
        _ -> "not 0, 1, or 2"
      end
    end
  end
end

ExUnit.start

defmodule ConditionalsTest do
  use ExUnit.Case

  test "Case.simple" do
    assert Conditionals.Case.simple() == "simple"
  end

  test "Case.number_names" do
    assert Conditionals.Case.number_names(0) == "zero"
    assert Conditionals.Case.number_names(1) == "one"
    assert Conditionals.Case.number_names(2) == "two"
    assert Conditionals.Case.number_names(3) == "not 0, 1, or 2"
  end
end
