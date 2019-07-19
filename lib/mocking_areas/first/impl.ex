defmodule MockingAreas.First.Impl do
  @behaviour MockingAreas.First

  import MockingAreas.AreaAccess

  def some do
    other_result = impl(MockingAreas.Second).other()

    {:ok, other_result}
  end
end
