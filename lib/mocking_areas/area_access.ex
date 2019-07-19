defmodule MockingAreas.AreaAccess do
  @areas [
    MockingAreas.First,
    MockingAreas.Second,
    MockingAreas.Third
  ]

  defmacro __using__(:all) do
    quote do
      import MockingAreas.AreaAccess, only: [impl: 1]
    end
  end

  defmacro __using__(mod_asts) when is_list(mod_asts) do
    mods = Enum.map(mod_asts, &Macro.expand(&1, __CALLER__))

    quote do
      import MockingAreas.AreaAccess, only: [impl: 1]

      Module.put_attribute(__MODULE__, :area_impl_def, unquote(mods))
      Module.register_attribute(__MODULE__, :area_impl_call, accumulate: true)
      @before_compile MockingAreas.AreaAccess
    end
  end

  defmacro __before_compile__(env) do
    defined = Module.delete_attribute(env.module, :area_impl_def)
    called = Module.delete_attribute(env.module, :area_impl_call) |> Enum.uniq

    undefined = Enum.map(called -- defined, &inspect/1)
    if Enum.any?(undefined), do: raise("calling unlisted area #{Enum.join(undefined, ", ")}")

    uncalled = Enum.map(defined -- called, &inspect/1)
    if Enum.any?(uncalled), do: raise("unused area #{Enum.join(uncalled, ", ")}")
  end

  defmacro impl(mod_ast) do
    mod = Macro.expand(mod_ast, __CALLER__)
    unless mod in @areas, do: raise("unknown area #{inspect(mod)}")

    if Module.get_attribute(__CALLER__.module, :area_impl_def) do
      Module.put_attribute(__CALLER__.module, :area_impl_call, mod)
    end

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

  def define_mox_mocks do
    for mod <- @areas, do: apply(Mox, :defmock, [mock_impl(mod), [for: mod]])
  end

  def install_mox_stubs do
    for mod <- @areas, do: apply(Mox, :stub_with, [mock_impl(mod), real_impl(mod)])
  end
end
