ExUnit.start

defmodule OperatorsTest do
  use ExUnit.Case

  test "++" do

    # This means accessing the length of a list is a linear operation: we need
    # to traverse the whole list in order to figure out its size. Updating a
    # list is fast as long as we are prepending elements:

    assert [1,2,3] ++ [4] == [1,2,3,4]    # slower
    assert [1] ++ [2,3,4] == [1,2,3,4]    # faster
  end

  test "<>" do

    assert "a" <> "b" == "ab"
  end

  test "and, or, not" do

    # These operators are strict in the sense that they expect a boolean (true
    # or false) as their first argument:

    assert (true  or false) ==  true
    assert (true and false) == false
    assert (not  true)      == false
    assert (not false)      ==  true
    assert (not not true)   ==  true

    # or and and are short-circuit operators. They only execute the right side
    # if the left side is not enough to determine the result:
    assert (true or 1/0) == true
  end

  test "&&, ||, !" do
    # These operators accept any arguments
    assert (1 && 2) == 2
    assert (1 || 2) == 1
    assert (!1)     == false
  end

  test "comparison" do
    assert 1  == 1.0
    assert 1 !== 1.0
  end
end

