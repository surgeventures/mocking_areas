defmodule MockingAreasTest do
  use ExUnit.Case

  setup do
    Mox.stub_with(MockingAreas.Second.Mock, MockingAreas.Second.Impl)
    :ok
  end

  test "normal case" do
    import MockingAreas.AreaImpl

    assert {:ok, :ok} = impl(MockingAreas.First).some()
  end

  test "mocked case" do
    import MockingAreas.AreaImpl

    Mox.expect(MockingAreas.Second.Mock, :other, fn -> :mocked end)

    assert {:ok, :mocked} = impl(MockingAreas.First).some()
  end
end
