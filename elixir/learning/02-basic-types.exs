defmodule Basic do
end

ExUnit.start

defmodule BasicTest do
  use ExUnit.Case

  test "arithmetic" do
    assert 1   + 2  == 3
    assert 1   + 2  == 3.0
    assert 1.0 + 2  == 3.0
    assert 5   / 10 == 0.5
    assert 5.0 / 10 == 0.5

    assert div(10, 2) == 5

    assert     9 / 5  == 1.8
    assert div(9,  5) == 1.0
  end

  test "rounding" do
    assert round(3.49) == 3
    assert round(3.50) == 4

    assert trunc(3.50) == 3
    assert trunc(3.99) == 3
  end

  test "type checking" do
    assert is_boolean(true)  ==  true
    assert is_boolean(false) ==  true
    assert is_boolean(1)     == false

    assert is_atom(:a)   ==  true
    assert is_atom('a')  == false

    assert is_binary("a")     ==  true
    assert is_binary(<<"a">>) ==  true
    assert is_binary('a')     == false

    assert is_bitstring("a")     ==  true
    assert is_bitstring(<<"a">>) ==  true
    assert is_bitstring('a')     == false

    assert is_float(1.0) ==  true
    assert is_float(1)   == false

    foo = fn _ -> end

    assert is_function(fn -> end) ==  true
    assert is_function(foo)       ==  true
    assert is_function(foo, 1)    ==  true
    assert is_function(foo, 2)    == false

    assert is_integer(1)   ==  true
    assert is_integer(1.0) == false

    assert is_list([1,2,3]) == true

    assert is_map(%{:a => 1}) == true

    assert is_nil(nil) == true

    assert is_number(1)      == true
    assert is_number(1.0)    == true
    assert is_number(1.0e-6) == true
    assert is_tuple({1, 2})  == true
  end

  test "lists" do
    assert [1] ++ [2] == [1, 2]
    assert [1] -- [1] ==     []
    assert [1] -- [2] ==    [1]

    assert [1, 2, 3] --    [2] == [1, 3]
    assert [1, 2, 2] --    [2] == [1, 2]
    assert [1, 2, 2] -- [2, 2] ==    [1]

    list = [1, 2, 3]
    assert hd(list) == 1
    assert tl(list) == [2, 3]

    # http://elixir-lang.org/getting-started/basic-types.html#linked-lists
    #
    # When Elixir sees a list of printable ASCII numbers, Elixir will print
    # that as a char list (literally a list of characters). Char lists are
    # quite common when interfacing with existing Erlang code.

    assert [61, 62]  == '=>'
  end

  test "tuples" do

    # Elixir uses curly brackets to define tuples. Like lists, tuples can hold
    # any value:

    tuple = {:ok, "Foo"}

    assert tuple_size(tuple) == 2
    assert elem(tuple, 0)    == :ok
    assert elem(tuple, 1)    == "Foo"
  end
end
