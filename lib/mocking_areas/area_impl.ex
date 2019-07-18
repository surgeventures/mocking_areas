defmodule MockingAreas.AreaImpl do
  def impl(mod) do
    :mocking_areas
    |> Application.get_env(mod, [])
    |> Keyword.get_lazy(:impl, fn -> Module.concat(mod, "Impl") end)
  end
end
