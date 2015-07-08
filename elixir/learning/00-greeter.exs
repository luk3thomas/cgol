# http://elixir-lang.org/getting-started/pattern-matching.html

defmodule Greeter do
  def greet,       do: "hello world"
  def greet(name), do: "hello #{name}"
end

ExUnit.start

defmodule GreeterTest do
  use ExUnit.Case

  test ".greet" do
    assert Greeter.greet() == "hello world"
  end

  test ".greet by name" do
    assert Greeter.greet('jake') == "hello jake"
  end
end
