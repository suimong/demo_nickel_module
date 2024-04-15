let builders_with_inputs = import "modules_with_inputs.ncl" in
let builders_bare = import "modules_bare.ncl" in
{
  fooShellBuilder | builders_with_inputs.ShellBuilder = builders_with_inputs.ShellBuilder & {
    inputs = {
      env = {"B" = "BB"},
      enw 
        | doc m%"
        With the contract attached to fooshellbuilder, the lsp will warn you about contract being broken,
        i.e. `enw` field does not exist in builders.ShellBuilder.

        Uncomment the section to see the action.
        "%
        = {C = "C"},
      name = "foo",
      buildScript = "echo foo > $out",
    },
  },
  barShellBuilder | builders_bare.ShellBuilder = builders_bare.ShellBuilder & {
    env = {"B" = "BB"},
    # enw = {C = "C"},
    name = "bar",
    buildScript = "echo foo > $out",
  }
}