# <img src="site\assets\logo.png" width="42" align="left"> Ghosty

### What is Ghosty?
An intuitive and feature-packed Roblox game framework.


### Why Ghosty?
While other game frameworks exist (most notably AGF & Knit), Ghosty provides a different feature set as well as a different focus. Ghosty was created around the idea that organization comes before everything else. Many games tend to quickly become disorganized as they get populated with more and more scripts. Ghosty solves this problem through [executables](https://thecobraboy2.github.io/Ghosty/wiki/Executables), module scripts Ghosty can read and assign to the server and client for simple communication between them. Ghosty also makes giving users the ability to manipulate the control flow of their scripts a priority including in an asynchronous manner.

### Get Ghosty
* [Roblox Model](https://www.roblox.com/library/6892133318/Ghosty)
* [Latest Release - Rojo Support](https://thecobraboy2.github.io/Ghosty/releases)

### Documentation
Check out the [Official Ghosty Documentation](https://astrealrblx.github.io/Ghosty/) for documentation and a full tutorial on the various features of Ghosty.

### Example
```lua
-- Main.lua (Server Script)
local Ghosty = require(game.ReplicatedStorage.Ghosty)
local PlayerMoney = Ghosty.import('Money/PlayerMoney.Server')

-- Control flow of the server
Ghosty.Server.Execute({
  PlayerMoney
})
```
```lua
-- Main.lua (Local Script)
local Ghosty = require(game.ReplicatedStorage.Ghosty)
local PlayerMoney = Ghosty.import('Money/PlayerMoney.Client')

-- Control flow of the client
Ghosty.Client.Execute({
  PlayerMoney
})
```
```lua
-- PlayerMoney.Server.lua (Module Script)
local PlayerMoney = { Name = 'PlayerMoney', Async = false }

PlayerMoney.Players = {}

function PlayerMoney.OnExecute()
  -- Register bridge for getting money from the client
  -- Client -> Server
  PlayerMoney.Ghosty.RegisterBridge('PlayerMoney/GetMoney', function(player)
    return PlayerMoney.Players[player]
  end)

  -- Set default player money upon join
  game:GetService('Players').PlayerAdded:Connect(function(player)
    PlayerMoney.SetMoney(player, 15)
  end)
end

function PlayerMoney.SetMoney(player, amount)
  PlayerMoney.Players[player] = amount
end

return PlayerMoney
```
```lua
-- PlayerMoney.Client.lua (Module Script)
local PlayerMoney = { Name = 'PlayerMoney', Async = false }

function PlayerMoney.OnExecute()
  print(PlayerMoney.Ghosty.GetBridge('PlayerMoney/GetMoney'):Fire()) --> Prints 15
end

return PlayerMoney
```
