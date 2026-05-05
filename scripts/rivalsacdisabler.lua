for _, func in getgc() do
    if typeof(func) == "function" and debug.info(func, "s"):find("AnalyticsPipelineController") then
        hookfunction(func, function()
            return task.wait(8999999488)
        end)
    end
end

local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local LocalPlayer = Players.LocalPlayer

local fakeClientAlert = Instance.new("RemoteEvent")
fakeClientAlert.Name = "ClientAlert"
fakeClientAlert.Parent = LocalPlayer

local playerMeta = getrawmetatable(LocalPlayer)
local oldNamecall = playerMeta.__namecall
setreadonly(playerMeta, false)
playerMeta.__namecall = newcclosure(function(self, ...)
    if getnamecallmethod() == "WaitForChild" and select(1, ...) == "ClientAlert" then
        return fakeClientAlert
    end
    return oldNamecall(self, ...)
end)
setreadonly(playerMeta, true)

local gameMeta = getrawmetatable(game)
local oldGameNamecall = gameMeta.__namecall
setreadonly(gameMeta, false)
gameMeta.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if self == LocalPlayer and (method == "Kick" or method == "kick") then
        return
    end
    if method:lower():find("kick") or method == "Shutdown" then
        return
    end
    if method == "FireServer" and self == fakeClientAlert then
        return
    end
    return oldGameNamecall(self, ...)
end)
setreadonly(gameMeta, true)

local antiCheatScript = ReplicatedFirst:WaitForChild("LocalScript3", 10)
local hookedCount = 0

for _, func in getgc(false) do
    if typeof(func) == "function" then
        local success, env = pcall(getfenv, func)
        if success and env then
            local scriptRef = rawget(env, "script")
            if scriptRef and (scriptRef == antiCheatScript or tostring(scriptRef):find("LoadingScreen")) then
                local ok, constants = pcall(debug.getconstants, func)
                if ok then
                    for _, constant in constants do
                        if typeof(constant) == "string" and (constant:find("TakeTheL") or constant:find("ban") or constant:find("kick")) then
                            hookfunction(func, function() end)
                            hookedCount = hookedCount + 1
                            break
                        end
                    end
                end
            end
        end
    end
end