defmodule DefaultCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import MockingAreas.AreaAccess
    end
  end

  setup do
    MockingAreas.AreaAccess.install_stubs()
    :ok
  end
end
