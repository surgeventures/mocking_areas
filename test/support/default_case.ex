defmodule DefaultCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Modular.AreaAccess, :all
    end
  end

  setup do
    Modular.AreaAccess.install_mox_stubs()
    :ok
  end
end
