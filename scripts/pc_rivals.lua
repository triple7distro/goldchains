if not getgenv().l0ader then
    game:GetService("Players").LocalPlayer:Kick("bypassing loader huh?")
    return
end

-- DO NOT TOUCH ANYTHING ABOVE THIS, ITS FINISHED AND FUNCTIONAL
-- START OF THE ACTUAL SCRIPT BELOW

local repo = 'https://raw.githubusercontent.com/triple7distro/goldchains/main/'

local Library = loadstring(game:HttpGet(repo .. 'src/UI_library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'src/UI_theme.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'src/UI_save.lua'))()

local Window = Library:CreateWindow({
    Title = 'platinium chains rivals',
    Center = true,
    AutoShow = false,
    TabPadding = 8,
    MenuFadeTime = 0
})

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

    Library:SetWatermark(('platinium chains | %s fps | %s ms'):format(
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