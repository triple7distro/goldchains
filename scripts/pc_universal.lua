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

-- Test if library loaded
if not Library then
    game.Players.LocalPlayer:Kick("Failed to load UI library")
    return
end

Library:Notify("platinium user detected")

local Window = Library:CreateWindow({
    Title = 'platinium chains universal',
    Center = true,
    AutoShow = false,
    TabPadding = 8,
    MenuFadeTime = 0
})

-- Test if window created
if not Window then
    game.Players.LocalPlayer:Kick("Failed to create UI window")
    return
end

local Tabs = {
    Main = Window:AddTab('Main'),
    Player = Window:AddTab('Player'),
    ['UI Settings'] = Window:AddTab('UI Settings')
}

-- Test if tabs created
if not Tabs.Main or not Tabs.Player or not Tabs['UI Settings'] then
    game.Players.LocalPlayer:Kick("Failed to create UI tabs")
    return
end

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
    Library:SetWatermarkVisibility(false)
end)

local AntiAimGroup = Tabs.Player:AddLeftGroupbox('Anti Aim')

local antiAimEnabled = false
local antiAimConnection
local aimSpeed = 1

AntiAimGroup:AddToggle('Anti Aim', {
    Text = 'Enable Anti Aim',
    Default = false,
    Func = function(Value)
        antiAimEnabled = Value
        
        if antiAimEnabled then
            antiAimConnection = game:GetService('RunService').Heartbeat:Connect(function()
                local character = game.Players.LocalPlayer.Character
                if character and character:FindFirstChild('Humanoid') and character:FindFirstChild('HumanoidRootPart') then
                    local currentCFrame = character.HumanoidRootPart.CFrame
                    
                    -- Jitter effect with speed control
                    local jitterAngle = math.random(-15, 15) * aimSpeed
                    local offsetCFrame = currentCFrame * CFrame.Angles(0, math.rad(jitterAngle), 0)
                    
                    character.HumanoidRootPart.CFrame = offsetCFrame
                end
            end)
        else
            if antiAimConnection then
                antiAimConnection:Disconnect()
                antiAimConnection = nil
            end
        end
    end
})

AntiAimGroup:AddSlider('Aim Speed', {
    Text = 'Aim Speed',
    Default = 1,
    Min = 0.1,
    Max = 5,
    Rounding = 1,
    Callback = function(Value)
        aimSpeed = Value
    end
})


local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'Insert', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('pc_universal')
SaveManager:SetFolder('pc_universal')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
SaveManager:LoadAutoloadConfig()

Library:Notify("platinium chains loaded")
Library.Toggle()