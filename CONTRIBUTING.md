# Contributing

This document explains the process of contributing to this project.

First of all please follow the [CODE_OF_CONDUCT](./CODE_OF_CONDUCT.md) in all your interactions within the project.


TODO

## Styling

More debateful, but actually have less consequence.

1. For style, there is no personal preference, always use `go fmt` as a standard.

1.  if statement doesn't flow into the next statement—that is, the body ends in break, continue, goto, or return—the unnecessary else is omitted.

1. No indented if/else.. only one. If more than one, use switch/case. Also if there is a case and a default, don't use switch, use if, else.

1. Use `if` first argument, if an expr is only useful for if condition and not more than that.

1. **File order:**
    - package
    - imports
    - const
    - var
    - types, and corresponding methods
    - functions

1. **Naming:**

    - getters does not need `Get` for unexported fields. only PascalCase field. If exported field, use `Get` + field.
    - setters: `Set` + PascalCased field.
    - one-method interfaces are named by the method name plus an -er suffix
    - method on a well-known type, give it the same name and signature; call your string-converter method String not ToString
    - constructor functions: `New` + `Type`
    - Do not include parent name in child name. e.g. no struct field with AnimalName when struct itself is Animal. Also in terraform modules, do not include module name in resource name ,however always include it in metadata name (the "name" property of the resource)

1. **Order of args in a function:**
    - ctx first
    - err second
    - sort by importance? group same types

    For return
    - err last

## Principles:


1. **DRY:** Always use variables, if some piece of info is occuring more than once. Define a function if a piece of code is repeating more than once.

1. **YAGNI:** No need to plan for future, if we ever need it we will implement it later..

1. **Do not hardcode:** use passable methods (flags, config, env) for configurations that can be changed in different deployments/setups and do not hardcode values in code.

1. **Write tests:** Please do not merge any feature into master unless you have writen tests for it.

1. **Method vs Function:**

    - If an object needs to be passed by refrence, and the values are modified in a function, this should be a method for that type. If the function does not modify any pointer value, and only returns a value, it should be a function.

    - What about chaining? if return value is same as one of inputs (the main one)

    - Stateful: what if a method needs some values for a client (like k8s client)? isn't it easier to have a struct and save the client/logger, etc there and use it instead? (reference)

    - for implementing interfaces, use method (value/refrenced base)

    - For getter/setters, use method (reference based)

1. **Pass by Value, or, Pass by Reference**:

    - if a variable is needed to be modified, pass it by refrence. (Is it better to avoid this as much as possible? by passing a copy, modifying the object, and again returning the object, overwriting the previous.)

    - If variable is a large struct and performance is an issue, it’s preferable to pass variable by pointer. So that to avoid expensive copying of the whole struct in memory.

    - Maps and slices are reference types in Go and should be passed by values.

    - Json marshal/unmarshal `omitempty`.

    - In all other cases, prefer pass by value.

1. **Function input as struct type or many primitive types?**:

    - some point here is that is you only use a small number of struct properties, only pass them, not the whole struct (inteface segregation)

1. **Same package, or, Separate package:**

    - If some config needs to be shared to all function, they should be on the same package.

1. **Same file, or, Separate file:**

1. **No global varialbes:**

    - A shared config which all components need?
    - A logger which all functions need?

1. Define getters for type fields which are map/slice or struct pointer to avoid nil pointer derefrence issues in runtime. what if we could define `GetTypeA() (value, error)` and calling `a.GetTypeA().GetTypeB()` like rust, invoked errors.

1. Define constructors for structs with the name "New" + Type, when:
    - default value is requied
    - have struct-pointer/map/slice values to avoid nil pointer derefrence issues. This should cascade to all supersede structs which embeds/contains this struct. (Shouldn't we use either GetField method or NewType method?)

1. **Exported vars, functions:** only if it is really required to have access from outside of the package. Consider YAGNI.
    - For exported vars, use Getter and (Setters/Constructors) with unexported vars. (??)

1. **Log in functions, or, not:**

    - For erros return err with more context Errorf and only log in main funcs
    - For non-failing erros, return until we want to log and ignore the warning, and then log it (as we no longer want to passs the err to the parrent caller)
    - For infos: log before function call.

1. **Define var and function for not repetitive expressions:**

    - Big expressions, chained functions, ...
    - Doing some stuff in series, but smaller functions makes them more testable.

1. **Do not import by .** unless for tests which are running outside of the package they are testing.

1. **return value names:** It's good to use as they can explain what are the return values, but also avoid using simple return without explicitly returning values.

1. An struct with only one property should be avoided (use type only). Consider YAGNI

1. **Do not panic:** return err and handle in higher level. panic, os.Exit,... should happen ONLY in main func.

1. **context:**
    - when there is an external call of anytime, pass the context from main all the way down to that funtion.
    - If a function does not have any external call, nor need any cleanup, it does not need context


## Logging

[klog](https://github.com/kubernetes/klog) is used in this repo for logging, and not any other logging tool should be used (logrus, etc). Also `fmt` stdout/stderr should be avoided.

Always use V levels for your log, unless:

* It is a fatal error which causes process to be terminated

* It is only printed once on the startup/termination, such as config load info, driver info, etc.

Log levels:

1. Errors: An operation did not completed and the component didn't have the expected functionality. However this error does not termiante the app process.

2. Warnings: Operation completed, but there was some issues.

3. Info: Important events:

    * gRPC Service.Method calls

4. Additional info for events:

    * Operation info logs in grpc methods such as resource creation, deletion, update, etc.

5. Debugging:

    * gRPC request and response logs

6. Debugging:

    * HTTP URL/METHOD requests sent to external components

7. Debugging:

    * HTTP Headers, Body requests sent to external components
