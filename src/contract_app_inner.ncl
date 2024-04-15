{
  A = {
    inputs = {
      a = 1,
      b.c | Number,
      b.d | Bool,
    },
  },
  A2 = {
    inputs | {
      a = 1,
      b.c | Number,
      b.d | Bool,
    }
  },

  a | A = A & {
    inputs.b.c = 1,
    inputs.b.d = true,
    inputs.e = "ha",
    # e = "ha",
  },

  a2 | A2 = A2 & {
    inputs.b.c = 1,
    inputs.b.d = true,
    # inputs.e = "ha",
    # e = "ha",
  },
  A3 = A2 & {
    inputs.b.e | {f | String},
  },
  a3 | A3 = A3 & {
    inputs.b.c = 1,
    inputs.b.d = false,
    inputs.b.e.f = "hello",
    # inputs.b.e.g = 5,
    inputs.b.f = "6",
  }
}