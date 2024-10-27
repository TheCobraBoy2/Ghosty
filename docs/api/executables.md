# Executable API

## Ghosty
Ghosty injects directly into an executable directly before execution under `MyExecutableTable.Ghosty`.
> #### `Module|Executable|Library Ghosty.import(Path importPath [, Instance startDirectory])`
> For more information view [Imports](../../start/#imports)

## Server
Executables have access to the same functions as [Ghosty's Server](../Ghosty/#server). The Server injects into an executable directly before execution under `MyExecutableTable.Ghosty.Server`.

> #### `Bridge Server.RegisterBridge(Path bridgePath [, function callback])`
> Register a new bridge to go client to server or server to client. View the [Bridge API](../bridges) to learn more.

## Client
Executables have access to the same functions as [Ghosty's Client](../Ghosty/#client). The Client injects into an executable directly before execution under `MyExecutableTable.Ghosty.Client`.

> #### `Bridge Client.GetBridge(Path bridgePath)`
> Get an existing bridge. View the [Bridge API](../bridges) to learn more.