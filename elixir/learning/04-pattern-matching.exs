ExUnit.start

defmodule PatternMatchingTest do
  use ExUnit.Case

  test "match operator" do
    x = 1
    1 = x
    assert x == 1
    assert_raise MatchError, fn -> 2 = x end

    {a, b, c} = {:ok, 1, [1,2,3]}
    assert a == :ok
    assert b == 1
    assert c == [1,2,3]

    [a, b, c] = [1, 2, 3]
    assert a == 1
    assert b == 2
    assert c == 3


    # More interestingly, we can match on specific values. The example below
    # asserts that the left side will only match the right side when the right
    # side is a tuple that starts with the atom :ok:

    {:ok, d} = {:ok, 1}
    assert d == 1


    # lists can match on head and tail

    [head|tail] = [1, 2, 3]
    assert head == 1
    assert tail == [2, 3]


    # head and tail can prepend an item to a list
    assert [0|[1, 2]] == [0, 1, 2]
  end

  test "pin operator" do
    x = 1
    assert_raise MatchError, fn -> ^x = 2 end

    # The pin operator ^ can be used when there is no interest in rebinding a
    # variable but rather in matching against its value prior to the match:

    {x, ^x} = {2, 1}
  end
end
