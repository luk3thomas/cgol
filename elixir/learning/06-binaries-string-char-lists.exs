ExUnit.start

defmodule BinTest do
  use ExUnit.Case

  # A string is a UTF-8 encoded binary, and a binary is a bitstring where the
  # number of bits is divisible by 8.

  test "utf-8" do
    string = "hellØ"
    assert byte_size(string) == 6
    assert String.length(string) == 5

    # Char character
    assert ?A == 65
    assert String.codepoints(string) == ["h", "e", "l", "l", "Ø"]
  end

  test "binary" do
    assert <<0, 1>> <> <<2>> == <<0, 1, 2>>

    # Each number given to a binary is meant to represent a byte and therefore
    # must go up to 255. Binaries allow modifiers to be given to store numbers
    # bigger than 255 or to convert a code point to its utf8 representation:

    assert <<256>> == <<0>>
    assert <<257>> == <<1>>
    assert <<258>> == <<2>>
    assert <<512>> == <<0>>


    assert <<1 :: 1>> == <<1 :: size(1)>>
    assert <<1 :: 8>> == <<1>>
    assert <<2 :: 8>> == <<2>>

    assert <<2 :: 8>> <> <<1>> == <<2, 1>>


    # We can also pattern match on binaries / bitstrings:
    <<0, 1, x>> = <<0, 1, 99>>
    assert x == 99

    <<0, 1, x :: binary>> = <<0, 1, 99, 98, 97>>
    assert x == <<99, 98, 97>>
    assert x == "cba"

    <<"AB">> <> c = <<"ABC">>
    assert c == "C"

  end
end
