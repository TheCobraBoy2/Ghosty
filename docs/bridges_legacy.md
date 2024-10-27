# Bridges (LEGACY)
!!! danger
    This page contains documentation for a legacy feature available from v1.0.0 to v1.0.3. If you are new to Ghosty it is recommended you use the [more recent and maintained version of Bridges](/bridges) 
Bridges replace the need for RemoteFunctions and RemoteEvents in Ghosty. They are used to communicate client -> server and server -> client.

## Creating a Bridge
Bridges are created within executables.
=== "Client To Server"

    !!! example "SomeExecutable.Server"
        ```lua
        local MyExe = { Name = 'MyExe', Async = false }

        local function RegisterBridges()
            MyExe.Ghosty.RegisterBridge('MyBridge', function(player)
                print('From client to server!')
            end)
        end

        function MyExe.OnExecute()
            RegisterBridges()
        end

        return MyExe
        ```

    !!! example "SomeExecutable.Client"
        ```lua
        local MyExe = { Name = 'MyExe', Async = false }

        function MyExe.OnExecute()
            MyExe.Ghosty.GetBridge('MyBridge'):Fire()
        end

        return MyExe
        ```

=== "Server To Client"

    !!! example "SomeExecutable.Server"
        ```lua
        local MyExe = { Name = 'MyExe', Async = false }

        local someBridge

        local function RegisterBridges()
            someBridge = MyExe.Ghosty.RegisterBridge('MyBridge')
        end

        function MyExe.OnExecute()
            RegisterBridges()

            --[[
                Later in your executable, once you've ensured the client has executed,
                you can call the :Fire() method on the bridge

                E.g.
                someBridge:Fire()
            ]]
        end

        return MyExe
        ```

    !!! example "SomeExecutable.Client"
        ```lua
        local MyExe = { Name = 'MyExe', Async = false }

        function MyExe.OnExecute()
            MyExe.Ghosty.GetBridge('MyBridge'):Hook(function()
                print('From server to client!')
            end)
        end

        return MyExe
        ```

!!! warning
    All bridges must be registered on the server. The client does not have access to the `RegisterBridge` function.

## Organizing Bridges
Staying organized with your bridges is important. That's why bridges use a similar directory system to Ghosty's [import](/start/#Ghosty-directory-system) function. Bridges are placed within Ghosty in a folder that is generated upon server start called `Bridges`. When you create a bridge and provide it a name you can actually provide a directory to create for it too. If the directory already exists it will simply use that directory rather than creating another one.

```lua
--- Bridges
----- SomeBridges
-------- MyBridge
MyExe.Ghosty.RegisterBridge('MyExe/SomeBridges/MyBridge')
```

!!! tip
    Bridges are not bound to their executables. You can get and use a bridge from another executable!