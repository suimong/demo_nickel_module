{
  Module = {inputs | not_exported | {..}, ..},
  mod_base 
  | Module
  = {
    inputs | not_exported = {
        foo
          | String
          | doc "Doc of foo",
        bar
          | Number
          | doc "Doc of bar",
        unused
          | Bool
          | optional,
      },
    local | not_exported = {
        computed = std.string.lowercase inputs.foo,
      },

    some_config_option = inputs.bar + 1,
    other_option = std.string.join ["Hello", local.computed],
    last_option = "values are %{local.computed} and %{std.to_string inputs.bar}",
  },
  use_mod_base = mod_base & {
    inputs.foo = "a",
    inputs.bar = 42,
    inputs.unused = true,
  }
}
