**Is your feature request related to a problem? Please describe.**

I'm hoping to revive the discussion on the topic of "module", following #1505, now that a dedicated [documentation section](https://nickel-lang.org/user-manual/modular-configurations) that touched on this topic has been added. Below I'll try to identify the "features" that makes a module system ergonomic and powerful, and explore how well Nickel plays with these features.

# Overview

Desired "features" of a nickel configuration module: 

From both module writer & module user's POV:
- it is dynamic, i.e. it takes inputs (static module becomes a degenerated special case)

From module writer's POV:
- a new module can be composed from existing modules
- a new module can be extended from other modules
- a module should enforce a contract that users can follow

From module user's POV:
- The Nickel LSP should provide completion to the module's inputs and fields
- The Nickel program or LSP should help identify the mistakes:
  - mistyping a field name (i.e. adding new field to the module should not be allowed)
  - mismatch on value type (non-record value type enforced by contract, could be as simple as `String`, `Number`


We will be using the form of "module" outlined in the [documentation](https://nickel-lang.org/user-manual/modular-configurations#toward-modules) as the baseline of this discussion, i,e, a module is a record with .

``` nickel
# module.ncl

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

    a = inputs.bar + 1,
    b = std.string.join ["Hello", local.computed],
    c = "values are %{local.computed} and %{std.to_string inputs.bar}",
  },
  use_mod_base = mod_base & {
    inputs.foo = "a",
    inputs.bar = 42,
    inputs.unused = true,
  }
}

```



## About contract

- Contract that apply to a leaf value (i.e. non-record value)
- Contract that apply to a node (a record value)



## Config module scenarios

There is an axis on which configurations can be categorized in the following way:
- One that is 

IMHO it is helpful to (at least partially) categorize the configurations that people use and write in the wild on the axis of 

## Writing Modules


# Comparison with NixOS Module

- "module-list.nix"
  - globally imported modules
  - similar to rust prelude
- the global `config` argument
  - similar to a redux store, which stores all states of a particular configuration.
  - makes it possible for a NixOS module to implicitly depend on other parts of the configuration
  - which makes it powerful, but does not seem feasible, nor desirable to replicate such feature with Nickel module?