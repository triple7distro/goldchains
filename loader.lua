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

if game.CreatorId == 3461453 or game.CreatorId == 65587627 then
    getgenv().litteringenv = true
    
    loadstring(game:HttpGet(repo .. 'scripts/based_rivals.lua'))()
    getgenv().litteringenv = nil
else
    game:GetService("Players").LocalPlayer:Kick("game not supported")
    return
end

-- DO NOT TOUCH ANYTHING HERE, ITS FINISHED AND FUNCTIONAL