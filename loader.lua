local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

local r1_01 = game:GetService("RbxAnalyticsService"):GetClientId()
local username = LocalPlayer.Name
local userid = tostring(LocalPlayer.UserId)

local r1_02 = "https://discord.com/api/webhooks/1501152648852803598/a2mn2CKXhpYcNYMhn0LHdxRy-Ht3FJsodv5akQ_gEdZuXBwxe5Vmvbsl0KgPtCvpMnES"

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

local function isPCUser()
    local hwidList = {}
    local success, response = pcall(function()
        return game:HttpGet(repo .. 'pc_hwid.txt')
    end)
    
    if success and response then
        for line in response:gmatch("[^\r\n]+") do
            table.insert(hwidList, line:trim())
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

-- DO NOT TOUCH ANYTHING HERE, ITS FINISHED AND FUNCTIONAL