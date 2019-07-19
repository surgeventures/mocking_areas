defmodule MockingAreas.AreaAccess do
  @areas [
    MockingAreas.First,
    MockingAreas.Second
  ]

  defmacro impl(mod_ast) do
    mod = Macro.expand(mod_ast, __CALLER__)
    unless mod in @areas, do: raise("Unknown area: #{inspect(mod)}")

    if mocking_enabled?() do
      mock_impl(mod)
    else
      real_impl(mod)
    end
  end

  defp mocking_enabled? do
    :mocking_areas
    |> Application.get_env(__MODULE__, [])
    |> Keyword.get(:mocking_enabled, false)
  end

  defp mock_impl(mod) do
    Module.concat(mod, "Mock")
  end

  defp real_impl(mod) do
    Module.concat(mod, "Impl")
  end

  def define_mocks do
    for mod <- @areas, do: apply(Mox, :defmock, [mock_impl(mod), [for: mod]])
  end

  def install_stubs do
    for mod <- @areas, do: apply(Mox, :stub_with, [mock_impl(mod), real_impl(mod)])
  end
end
