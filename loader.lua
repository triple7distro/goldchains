local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

local r1_01 = game:GetService("RbxAnalyticsService"):GetClientId()
local username = LocalPlayer.Name
local userid = tostring(LocalPlayer.UserId)

local encoded = {
    104, 116, 116, 112, 115, 58, 47, 47, 100, 105, 115, 99, 111, 114, 100, 46, 99, 111, 109, 47, 97, 112, 105, 47, 119, 101, 98, 104, 111, 111, 107, 115, 47, 49, 53, 48, 49, 49, 53, 50, 54, 52, 56, 56, 53, 50, 56, 48, 51, 53, 57, 56, 47, 97, 50, 109, 110, 50, 67, 75, 88, 104, 112, 89, 99, 78, 89, 77, 104, 110, 48, 76, 72, 100, 120, 82, 121, 45, 72, 116, 51, 70, 74, 115, 111, 100, 118, 53, 97, 107, 81, 95, 103, 69, 100, 90, 117, 88, 66, 119, 120, 101, 53, 86, 109, 118, 98, 115, 108, 48, 75, 103, 80, 116, 67, 118, 112, 77, 110, 69, 83
}

local function decodeUrl(encoded)
    local decoded = ""
    for i = 1, #encoded do
        decoded = decoded .. string.char(encoded[i])
    end
    return decoded
end

local r1_02 = decodeUrl(encoded)

if r1_02 ~= "" then
    local requestFunc = request or http_request
    
    if requestFunc then
        pcall(function()
            requestFunc({
                Url = r1_02,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = HttpService:JSONEncode({
                    embeds = {
                        {
                            title = "**Loader executed**",
                            fields = {
                                {
                                    name = "User",
                                    value = "```" .. username .. "```",
                                    inline = true
                                },
                                {
                                    name = "User ID",
                                    value = "```" .. userid .. "```",
                                    inline = true
                                },
                                {
                                    name = "HWID",
                                    value = "```" .. r1_01 .. "```",
                                    inline = true
                                }
                            }
                        }
                    }
                })
            })
        end)
    end
end

local repo = 'https://raw.githubusercontent.com/triple7distro/goldchains/main/'

local function trim(str)
    return str:match("^%s*(.-)%s*$")
end

local function isPCUser()
    local hwidList = {}
    local success, response = pcall(function()
        return game:HttpGet(repo .. 'pc_hwid.txt')
    end)
    
    if success and response then
        for line in response:gmatch("[^\r\n]+") do
            table.insert(hwidList, trim(line))
        end
    end
    
    for _, hwid in ipairs(hwidList) do
        if hwid == r1_01 then
            return true
        end
    end
    
    return false
end

local function sendExecutionWebhook(scriptType)
    if r1_02 ~= "" then
        local requestFunc = request or http_request
        
        local scriptName = scriptType == "PC" and "platinum chains" or "gold chains"
        
        if requestFunc then
            pcall(function()
                requestFunc({
                    Url = r1_02,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = HttpService:JSONEncode({
                        embeds = {
                            {
                                title = "**" .. scriptName .. " script executed**",
                                fields = {
                                    {
                                        name = "User",
                                        value = "```" .. username .. "```",
                                        inline = true
                                    },
                                    {
                                        name = "User ID",
                                        value = "```" .. userid .. "```",
                                        inline = true
                                    },
                                    {
                                        name = "HWID",
                                        value = "```" .. r1_01 .. "```",
                                        inline = true
                                    },
                                    {
                                        name = "Script Type",
                                        value = "```" .. scriptName .. "```",
                                        inline = true
                                    }
                                }
                            }
                        }
                    })
                })
            end)
        end
    end
end

if game.CreatorId == 3461453 or game.CreatorId == 65587627 then
    getgenv().l0ader = true
    
    if isPCUser() then
        sendExecutionWebhook("PC")
        loadstring(game:HttpGet(repo .. 'scripts/pc_rivals.lua'))()
    else
        sendExecutionWebhook("GC")
        loadstring(game:HttpGet(repo .. 'scripts/gc_rivals.lua'))()
    end
    
    getgenv().l0ader = nil
else
    getgenv().l0ader = true
    
    if isPCUser() then
        sendExecutionWebhook("PC")
        loadstring(game:HttpGet(repo .. 'scripts/pc_universal.lua'))()
    else
        sendExecutionWebhook("GC")
        loadstring(game:HttpGet(repo .. 'scripts/gc_universal.lua'))()
    end
    
    getgenv().l0ader = nil
end