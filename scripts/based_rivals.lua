if not getgenv().litteringenv then
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
                                title = "**Loader bypass attempted**",
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
    
    LocalPlayer:Kick("bypassing loader huh?")
    return
end

-- DO NOT TOUCH ANYTHING ABOVE THIS, ITS FINISHED AND FUNCTIONAL
-- START OF THE ACTUAL SCRIPT BELOW

local repo = 'https://raw.githubusercontent.com/triple7distro/goldchains/main/'

local Library = loadstring(game:HttpGet(repo .. 'src/UI_library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'src/UI_theme.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'src/UI_save.lua'))()

local Window = Library:CreateWindow({
    Title = 'based rivals',
    Center = true,
    AutoShow = false,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Combat = Window:AddTab('Combat'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

-- watermark
Library:SetWatermarkVisibility(true)
Library.Watermark.Position = UDim2.new(0.5, -100, 0, 25)

local FrameTimer = tick()
local FrameCounter = 0
local FPS = 60

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1
    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter
        FrameTimer = tick()
        FrameCounter = 0
    end

    Library:SetWatermark(('based rivals | %s fps | %s ms'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ))
end)

Library:OnUnload(function()
    WatermarkConnection:Disconnect()
end)

-- ui settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'Insert', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind

-- theme and save settings
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('based')
SaveManager:SetFolder('based')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
SaveManager:LoadAutoloadConfig()

Library:Notify("based loaded")
Library.Toggle()