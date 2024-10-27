--[[

	Ghosty // Game Framework
	Created by TheCobraBoy2
	
	Version 1.1.0

]]

local initialTime = tick()

local Ghosty = { Core = {}, Libraries = {}, Config = require(script.Config), Root = script }

local core = script.Core
local lib = script.Libraries

local isClient = game:GetService('RunService'):IsClient()

-- Load core modules
for _, m in pairs(core:GetChildren()) do
	local src = require(m)
	if (src.constructor) then
		src.constructor(Ghosty.Config.Core[src.Name] or {})
	end
	src.constructor = nil
	src.Ghosty = Ghosty
	Ghosty.Core[src.Name] = src
end

-- Load library modules
for _, m in pairs(lib:GetDescendants()) do
	if (not m:IsA('ModuleScript')) then continue end
	local src = require(m)
	if (src.Name == nil) then
		error('All libraries must contain a Name property')
	end
	Ghosty.Libraries[src.Name] = src
end

-- Inject other libraries & call library constructors
for _, src in pairs(Ghosty.Libraries) do
	src.Ghosty = {
		Libraries = Ghosty.Libraries
	}
	if (src.constructor) then
		src.constructor()
		src.constructor = nil
	end
end

-- Define global Ghosty variables
Ghosty.import = Ghosty.Core.Import.new
Ghosty.BulkImport = Ghosty.Core.Import.bulk
Ghosty.Bridge = Ghosty.Core.Bridge

-- Provide respective side of Ghosty
if (not isClient) then
	Ghosty.Server = require(script.Server)(Ghosty)
	Ghosty.Bridges = Instance.new('Folder', Ghosty.Root)
	Ghosty.Bridges.Name = 'Bridges'
else
	Ghosty.Client = require(script.Client)(Ghosty)
	Ghosty.Bridges = script:FindFirstChild('Bridges')
end

-- Provide some debug information
if (Ghosty.Config.Debug == true) then
	print(string.format('%s LOADED (%fs)', isClient and 'CLIENT' or 'SERVER', tick() - initialTime))
else
	initialTime = nil
end

return Ghosty