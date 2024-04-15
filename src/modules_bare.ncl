{
  Derivation = {
    name | String,
    buildCommand = {
      executable | String,
      args | Array String,
    },
    env | { _ : String },
  },
  ShellBuilder =
    Derivation
    & {
      buildScript | String,
      buildCommand = {
        executable = "bash",
        args = ["-c", buildScript],
        newArg = "5",
      },
    },
}
