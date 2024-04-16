{
  Derivation = {
    inputs = {
      name | String,
      buildCommand = {
        executable | String,
        args | Array String,
      },
      env | { _ : String },
    },
  },
  BuildCommand = {
    executable | String,
    args | Array String,
  },
  Derivation2 = {
    inputs = {
      name | String,
      buildCommand | BuildCommand,
      env | { _ : String },
    },
  },
  ShellBuilder =
    Derivation
    & {
      inputs.buildScript | String,
      inputs.buildCommand = {
        executable = "bash",
        args = ["-c", inputs.buildScript],
        newArg = "5",
      },
    },
  ShellBuilder2 = 
    Derivation2
    & {
      inputs.buildScript,
      inputs.buildCommand | (BuildCommand & {
        executable = "bash",
        args = ["-c", buildScript],
        newArg | Bool,
      })
    }
  ,
  ShellBuilder3 = {
    inputs = Derivation2.inputs & {
      inputs.buildScript,
      inputs.buildCommand | (BuildCommand & {
        executable = "bash",
        args = ["-c", buildScript],
        newArg | Bool,
      })
    }
  } 
  ,
  a =
      ShellBuilder
      & {
        inputs = {
          name = "5",
          env = { a = "a" },
          enw = 7,
          buildCommand.newArg2 = 5,
          buildScript = "hahaha",
        } 
      } | ShellBuilder,
  b = ShellBuilder2 & {
    inputs = {
      name = "b",
      env = { b = "b"},
      buildCommand = {
        newArg = 5,
      },
      buildScript = "hahaha",
    }
  },
  c = ShellBuilder3 & {
    inputs = {
      name = "c",
      env = {c = "c",},
      buildCommand = {newArg = false,},
      buildScript = "hahaha",
    }
  }
}
