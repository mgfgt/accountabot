defmodule AccountabotTest do
  use ExUnit.Case
  doctest Accountabot

  test "greets the world" do
    assert Accountabot.hello() == :world
  end
end
