defmodule MockingAreasTest do
  use DefaultCase

  test "normal case" do
    assert {:ok, :ok} = impl(MockingAreas.First).some()
  end

  test "mocked case" do
    Mox.expect(impl(MockingAreas.Second), :other, fn -> :mocked end)

    assert {:ok, :mocked} = impl(MockingAreas.First).some()
  end
end
