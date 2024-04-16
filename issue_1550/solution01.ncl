let Module = {
  Options = {},
  config | Options = {},  # This is a big constraint: there are whole classes of config that does not conform to this style
}
in
let Module2 = {
  Options = {},
  config = {},  # This is a big constraint: there are whole classes of config that does not conform to this style
}
in
let builders = {
  Derivation =
    {
      Options = {
        name | String,
        buildCommand = {
          executable | String,
          args | Array String,
        },
        env | { _ : String } = {},
      },
    } | Module,
  Derivation2 =
    {
      Options = {
        name | String,
        buildCommand = {
          executable | String,
          args | Array String,
        },
        env | { _ : String } = {},
      },
      config | Options
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
  | doc m%"
  Extend the schema (Options), 
  attach the updated Options to config (implicit declare in config?),
  explicitly reference the new field from Options
  "%
  =
    Derivation2
    & {
      Options.buildScript | String,
      config | Options = {
          buildCommand.executable = "bash",
          buildCommand.args = ["-c", Options.buildScript],
        }
    },
  # Builder3 
  # | doc m%"
  # Extend the schema (Options), 
  # attach the updated Options to config (implicit declare in config?),
  # implicitly reference the new field from Options
  # "%
  # =
  #   {
  #     Options.buildScript | String,
  #     config | Options = {
  #       buildCommand.executable = "bash",
  #       buildCommand.args = ["-c", buildScript],
  #     }
  #   } | Derivation,
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
        config.buildCommand | builders.Builder1.config.buildCommand= {
          newArg = 5,
        }
      } & builders.Builder1
      |> std.record.get "config",
  builder2 =
    (
      {
        config.name = "foo",
        config.buildScript = "echo foo > $out",
        # Options.nbme,
        # config.nbme = "ccr",
        config.buildCommand.newArg = 5,
      }
      & builders.Builder2
    ).config,
  # builder3 =
  #   (
  #     (
  #       {
  #         Options.name = "bar",
  #         Options.buildScript = "echo foo > $out",
  #         Options.nbme = "bbr",
  #       }
  #       & builders.Builder3
  #     ) | builders.Builder3
  #   ).config,
  sys1 = sysConf.Sys1 & {
    config.env = {FOO = "FOO"},
    config.profile = "foo",
    config.packages = [builder1, builder2]
  }
  |> std.record.get "config",
  # sys2 = sysConf.Sys1 & 
}
