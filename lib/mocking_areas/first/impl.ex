defmodule MockingAreas.First.Impl do
  @behaviour MockingAreas.First

  use Modular.AreaAccess, [
    MockingAreas.Second
  ]

  def some do
    other_result = impl(MockingAreas.Second).other()

    {:ok, other_result}
  end
end
