{
  Derivation = {
    inputs = {
      name | String,
      buildCommand = {
        executable | String,
        args | Array String,
      },
      env | {_: String},
    },
  },
  ShellBuilder = Derivation & {
    inputs.buildScript | String,
    inputs.buildCommand = {
      executable = "bash",
      args = ["-c", inputs.buildScript],
      newArg = "5",
    },
  },
  a | ShellBuilder = ShellBuilder & {inputs = {name = "5", env = {a = "a"}, enw = 7, buildScript="hahaha"}},
}
