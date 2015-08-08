ExUnit.start

defmodule Test do

  use ExUnit.Case

  test "keyword lists (associative arrays)" do
    # An array of tuples is an associative arryy
    list = [{:a, 1}, {:b, 2}]
    assert list[:a] == 1
    assert list[:b] == 2

    # We can concat
    list2 = list ++ [{:c, 3}]
    assert list2[:a] == 1
    assert list2[:b] == 2
    assert list2[:c] == 3

    # Keyword lists can have duplicate keys. The first will always return
    list3 = [{:a, 0}] ++ list2
    assert list3[:a] == 0
    assert list3[:b] == 2
    assert list3[:c] == 3

    # Keyword lists are important because they have three special characteristics:

    # 1. Keys must be atoms.
    # 2. Keys are ordered, as specified by the developer.
    # 3. Keys can be given more than once.
  end

  test "maps" do
    # Maps are a key / value store

    map = %{:a => 1, :b => 2}
    assert map[:a] == 1
    assert map[:b] == 2
    assert map[:n] == nil

    # maps can be access by dot notation

    assert map.a == 1
    assert map.b == 2

    # maps can be updated
    map = %{map | a: 99, b: 200}

    assert map.a ==  99
    assert map.b == 200

    # When all the keys in a map are atoms, you can use the keyword syntax for
    # convenience:

    map = %{a: 1, b: 2}
    assert map[:a] == 1
    assert map[:b] == 2
    assert map[:n] == nil

    # maps may be destructured

    %{a: n} = map
    assert n == 1

    # Anything can by a key
    map = %{1 => 0, 2 => 1}
    assert map[1] == 0
    assert map[2] == 1
  end
end
