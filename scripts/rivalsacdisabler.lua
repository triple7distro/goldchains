local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local LocalPlayer = Players.LocalPlayer

for _, func in getgc() do
    if typeof(func) == "function" and debug.info(func, "s"):find("AnalyticsPipelineController") then
        hookfunction(func, function() end)
        break
    end
end

local fakeClientAlert = Instance.new("RemoteEvent")
fakeClientAlert.Name = "ClientAlert"
fakeClientAlert.Parent = LocalPlayer

local gameMeta = getrawmetatable(game)
local oldNamecall = gameMeta.__namecall
setreadonly(gameMeta, false)
gameMeta.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    
    if method == "WaitForChild" and select(1, ...) == "ClientAlert" then
        return fakeClientAlert
    end
    
    if (self == LocalPlayer and (method == "Kick" or method == "kick")) or 
       method:lower():find("kick") or method == "Shutdown" then
        return
    end
    
    if method == "FireServer" and self == fakeClientAlert then
        return
    end
    
    return oldNamecall(self, ...)
end)
setreadonly(gameMeta, true)

local antiCheatScript = ReplicatedFirst:WaitForChild("LocalScript3", 10)
local blockedStrings = {"TakeTheL", "ban", "kick"}

for _, func in getgc(false) do
    if typeof(func) == "function" then
        local success, env = pcall(getfenv, func)
        if success and env then
            local scriptRef = rawget(env, "script")
            if scriptRef and (scriptRef == antiCheatScript or tostring(scriptRef):find("LoadingScreen")) then
                local ok, constants = pcall(debug.getconstants, func)
                if ok then
                    for _, constant in constants do
                        if typeof(constant) == "string" then
                            for _, blocked in blockedStrings do
                                if constant:find(blocked) then
                                    hookfunction(func, function() end)
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end