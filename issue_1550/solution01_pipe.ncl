let Module = {
  Options = {},
  config | Options = {},  # This is a big constraint: there are whole classes of config that does not conform to this style
  outputs = {..},
}
in
let BuildCommand = {
  executable | String,
  args | Array String,
} in
let builders = {
  Derivation =
    {
      Options = {
        name | String,
        buildCommand | BuildCommand,  # The key difference: | vs =
        env | { _ : String } = {},
      }
    } | Module,
  Builder1 
  | doc "Extend the schema (Options), declare in config"
  =
    Derivation
    & {
      Options.buildScript | String,
      config = {
        buildScript,
        buildCommand.executable = "bash",
        buildCommand.args = ["-c", buildScript],
      }
    },
  Builder2 
  | doc "Extend the schema (Options), attach the updated Options to config (implicit declare in config?)"
  =
    Derivation
    & {
      Options.buildScript | String,
      config | Options = {
          buildCommand.executable = "bash",
          buildCommand.args = ["-c", Options.buildScript],
        }
    },
  Builder3 =
    {
      Options = {
        buildScript,
        buildCommand.executable = "bash",
        buildCommand.args = ["-c", buildScript],
      }
    } | Derivation,
}
in
let sysConf = {
  Sys =
    {
      Options = {
        profile | String,
        packages | Array builders.Builder2.Options,
      }
    } | Module,
  Sys1 =
    Sys
    & {
      Options.env,
      # config = {}
    },
}
in
{
  builder1 =
      {
        config.name = "foo",
        config.buildScript = "echo foo > $out",
        # config.nbme = "bbr",
      } & builders.Builder1
      |> std.record.get "config",
  builder1a =
    (
      {
        config.name = "foo1a",
        config.buildScript = "echo foo > $out",
        # config.nbme = "bbr",
      }
      & builders.Builder1
    ).config,
  builder2 =
    (
      {
        Options.name = "foo",
        Options.buildScript = "echo foo > $out",
        Options.nbme,
        config.nbme = "ccr",
      }
      & builders.Builder2
    ).config,
  builder3 =
    (
      (
        {
          Options.name = "bar",
          Options.buildScript = "echo foo > $out",
          Options.nbme = "bbr",
        }
        & builders.Builder3
      ) | builders.Builder3
    ).config,
  sys1 = sysConf.Sys1 & {
    config.env = {FOO = "FOO"},
    config.profile = "foo",
    config.packages = [builder1, builder2]
  }
  |> std.record.get "config",
  sys2 = sysConf.Sys1 & 
}
