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

Library:Notify("platinium user detected")

local Window = Library:CreateWindow({
    Title = 'platinium chains universal',
    Center = true,
    AutoShow = false,
    TabPadding = 8,
    MenuFadeTime = 0
})

local Tabs = {
    Main = Window:AddTab('Main'),
    Player = Window:AddTab('Player'),
    ['UI Settings'] = Window:AddTab('UI Settings')
}

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
local aimType = 'Normal'
local spinAngle = 0
local stutterEnabled = false

AntiAimGroup:AddToggle('Anti Aim', {
    Text = 'Enable Anti Aim',
    Default = false,
    Callback = function(Value)
        antiAimEnabled = Value
        
        if antiAimEnabled then
            antiAimConnection = game:GetService('RunService').Heartbeat:Connect(function()
                local character = game.Players.LocalPlayer.Character
                if character and character:FindFirstChild('Humanoid') and character:FindFirstChild('HumanoidRootPart') then
                    local currentCFrame = character.HumanoidRootPart.CFrame
                    local offsetCFrame = currentCFrame
                    
                    -- Apply stutter effect if enabled
                    if stutterEnabled and math.random() < 0.3 then
                        offsetCFrame = currentCFrame * CFrame.new(math.random(-0.2, 0.2), 0, math.random(-0.2, 0.2))
                    end
                    
                    if aimType == 'Normal' then
                        -- Normal spin (upright) - subtle rotation
                        spinAngle = spinAngle + (aimSpeed * 2)
                        offsetCFrame = offsetCFrame * CFrame.Angles(0, math.rad(spinAngle), 0)
                    elseif aimType == 'UpsideDown' then
                        -- Upside down spin - subtle flip
                        spinAngle = spinAngle + (aimSpeed * 2)
                        offsetCFrame = offsetCFrame * CFrame.Angles(math.rad(15), math.rad(spinAngle), 0) -- Small tilt instead of full flip
                    elseif aimType == 'Sideways' then
                        -- Character is sideways and spins - subtle tilt
                        spinAngle = spinAngle + (aimSpeed * 2)
                        offsetCFrame = offsetCFrame * CFrame.Angles(math.rad(30), math.rad(spinAngle), 0) -- 30 degree tilt instead of 90
                    elseif aimType == 'Random' then
                        -- Random sideways rotation - smaller range
                        offsetCFrame = offsetCFrame * CFrame.Angles(0, math.rad(math.random(-30, 30)), 0)
                    elseif aimType == 'Jitter' then
                        -- Fast sideways jitter - smaller range
                        local jitterAngle = math.random(-15, 15) * aimSpeed
                        offsetCFrame = offsetCFrame * CFrame.Angles(0, math.rad(jitterAngle), 0)
                    end
                    
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

AntiAimGroup:AddToggle('Stutter', {
    Text = 'Enable Stutter',
    Default = false,
    Callback = function(Value)
        stutterEnabled = Value
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

AntiAimGroup:AddDropdown('Aim Type', {
    Values = {'Normal', 'UpsideDown', 'Sideways', 'Random', 'Jitter'},
    Default = 'Normal',
    Callback = function(Value)
        aimType = Value
        spinAngle = 0 -- Reset spin angle when changing type
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