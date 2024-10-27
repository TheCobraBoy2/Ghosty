# Getting Started
Starting with Ghosty is straightforward, easy, and user-friendly.

## Installation
=== "Roblox Model"

    1. Get the Roblox Ghosty model [here](https://www.roblox.com/library/6892133318/).
    2. Use the Toolbox to place it under ReplicatedStorage.
    3. That's it!

=== "With Rojo"

    1. Download the ZIP from the latest release [here](https://github.com/astrealRBLX/Ghosty/releases).
    2. Unzip it and drag Ghosty into your Rojo project's `src` directory.
    3. Make sure to add Ghosty's `$path` under `ReplicatedStorage` in your `default.project.json`

## Configuration
Ghosty's config is compact and doesn't have anything that needs touching. Insure that GhostyPath is set to the path of your Ghosty module. You can mess with the root key if you would like your imports to begin somewhere else. For example, you may have a folder within ReplicatedStorage called Modules. If you wanted your import strings to start from within there you would set root to `#!lua game:GetService('ReplicatedStorage').Modules`.

!!! note
    Assume the root path remains unchanged from its default ReplicatedStorage value in the rest of the documentation examples.

## Imports
Ghosty provides users a useful import function. There's no longer a need to use Roblox's global require() function. Import is specifically tailored to meet the needs of Ghosty and you should prefer it whenever possible (which is almost always).

### Basic Importing
```lua
local Ghosty = require(game.ReplicatedStorage.Ghosty)
local SomeModule = Ghosty.import('MyModule')
```
You can also provide a directory to start you import in rather than Ghosty using the root directory.
```lua
local SomeModule = Ghosty.import('MyModule', script.Parent.Parent)
```

### Ghosty Directory System
Ghosty uses a powerful and intuitive directory system. This system strays away from Roblox's dot notation and chained `:FindFirstChild()` methods which can be repetitive, tedious to type, and very very long. Rather, Ghosty uses a directory system similar to your computer's file system.

Have a module deep within your root path and need to import it? Let's compare using Ghosty versus using the raw Roblox API.
=== "Ghosty"

    ```lua
    Ghosty.import('Some/Directory/MyModule')
    ```

=== "Roblox"

    ```lua
    require(game:GetService('ReplicatedStorage'):FindFirstChild('Some'):FindFirstChild('Directory'):FindFirstChild('MyModule'))
    ```

There's a pretty major difference here in terms of length and readability. On top of this imports have a priority system.

### Priority Order
When importing something Ghosty prioritizes files in certain directories first.

1. Import's optional 2nd argument
2. Root directory
3. Ghosty

### Special Import Properties
When Ghosty attempts to import a module it checks for a few things. First it will determine if the module is returning a table. If all the module returns is a value or a function or something that isn't a table then Ghosty will directly return that. Otherwise if the module is a table then Ghosty will check for an `importable` key in the returned table. If this is set to false Ghosty will spit out an error stating that the module is not importable. This is primarily used internally. Finally, Ghosty will check for an `OnImport` function in the returned table. If one exists it will call the function. This is useful if you want your modules to have some special behavior when imported. Here's an example of a module using these special properties.
```lua
local MyModule = { importable = true }

function MyModule.OnImport()
    print('Imported!')
end

return MyModule
```
!!! note
    These special properties are all entirely optional and are simply meant to add an extra layer of functionality to modules.

