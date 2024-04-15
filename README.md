# demo_nickel_module
Use Nickel for modular configuration.

## Scenarios

### Extension mechanism: Composition vs Inheritance


### Kinds of Configuration

- Lots of statically computed/defined value, a few inputs
- No statically computed/defined value, a few inputs


### Considerations: To allow or not allow extension

- allow extension: actually extending a module
- not allow exntension: using a module (prevent mistyping a field name etc.)

Because we are using "merge" to serve two purposes:

- defining new module by extending an existing module
- using a module (filling in inputs)

