defmodule DefaultCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use MockingAreas.AreaAccess, :all
    end
  end

  setup do
    MockingAreas.AreaAccess.install_mox_stubs()
    :ok
  end
end
