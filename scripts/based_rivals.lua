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

task.spawn(function()
    local Library = loadstring(game:HttpGet(repo .. 'src/UI_library.lua'))()
    task.wait(0.2)
    
    Library:Notify("loading components")
    
    local ThemeManager = loadstring(game:HttpGet(repo .. 'src/UI_theme.lua'))()
    task.wait(0.2)
    
    local SaveManager = loadstring(game:HttpGet(repo .. 'src/UI_save.lua'))()
    task.wait(0.2)
    
    Library:Notify("creating window")
    
    local Window = Library:CreateWindow({
        Title = 'based',
        Center = true,
        AutoShow = false,
        TabPadding = 8,
        MenuFadeTime = 0.2
    })

    task.wait(0.2)
    
    Library:Notify("setting up tabs")

    local Tabs = {
        Combat = Window:AddTab('Combat'),
        ['UI Settings'] = Window:AddTab('UI Settings'),
    }

    task.wait(0.2)

    -- Aimbot Configuration
    local AimbotSettings = {
        Enabled = false,
        Smoothness = 1,
        FOV = 600,
        ShowFOV = true,
        TeamCheck = false,
        Keybind = Enum.UserInputType.MouseButton2
    }

    -- Services
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera

    -- FOV Circle
    local FOVCircle = Drawing.new("Circle")
    FOVCircle.Thickness = 2
    FOVCircle.NumSides = 100
    FOVCircle.Visible = false
    FOVCircle.Color = Color3.fromRGB(255, 50, 50)
    FOVCircle.Transparency = 0.5
    FOVCircle.Filled = false

    -- Get closest target
    local function GetTarget()
        local target = nil
        local closestDist = AimbotSettings.FOV
        local mousePos = UserInputService:GetMouseLocation()

        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                if AimbotSettings.TeamCheck and player.Team == LocalPlayer.Team then
                    continue
                end

                local character = player.Character
                if character then
                    local humanoid = character:FindFirstChild("Humanoid")
                    local head = character:FindFirstChild("HeadHB") or character:FindFirstChild("Head") or character:FindFirstChild("UpperTorso")

                    if humanoid and humanoid.Health > 0 and head then
                        local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                        if onScreen then
                            local dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                            if dist < closestDist then
                                closestDist = dist
                                target = head
                            end
                        end
                    end
                end
            end
        end
        return target
    end

    -- Aimbot Tab
    local AimbotGroup = Tabs.Combat:AddLeftGroupbox('Aimbot')

    AimbotGroup:AddToggle('AimbotEnabled', {
        Text = 'enabled',
        Default = false,
        Callback = function(Value)
            AimbotSettings.Enabled = Value
            FOVCircle.Visible = Value and AimbotSettings.ShowFOV
        end
    })

    AimbotGroup:AddToggle('AimbotShowFOV', {
        Text = 'show fov circle',
        Default = true,
        Callback = function(Value)
            AimbotSettings.ShowFOV = Value
            FOVCircle.Visible = AimbotSettings.Enabled and Value
        end
    }):AddColorPicker('FOVColor', {
        Default = Color3.fromRGB(255, 50, 50),
        Title = 'fov color',
        Callback = function(Value)
            FOVCircle.Color = Value
        end
    })

    AimbotGroup:AddToggle('AimbotTeamCheck', {
        Text = 'team check',
        Default = false,
        Callback = function(Value)
            AimbotSettings.TeamCheck = Value
        end
    })

    AimbotGroup:AddSlider('AimbotSmoothness', {
        Text = 'smoothness',
        Default = 1,
        Min = 0.1,
        Max = 5,
        Rounding = 1,
        Compact = true,
        Callback = function(Value)
            AimbotSettings.Smoothness = Value
        end
    })

    AimbotGroup:AddSlider('AimbotFOV', {
        Text = 'fov radius',
        Default = 600,
        Min = 50,
        Max = 1500,
        Rounding = 0,
        Compact = true,
        Callback = function(Value)
            AimbotSettings.FOV = Value
            FOVCircle.Radius = Value
        end
    })

    AimbotGroup:AddLabel('keybind'):AddKeyPicker('AimbotKeybind', {
        Default = 'MB2',
        Mode = 'Hold',
        Text = 'aimbot keybind',
        NoUI = true,
        Callback = function(Value)
        end
    })

    -- Main Loop
    local Connection = RunService.RenderStepped:Connect(function()
        FOVCircle.Position = UserInputService:GetMouseLocation()
        FOVCircle.Radius = AimbotSettings.FOV

        if AimbotSettings.Enabled and Options.AimbotKeybind:GetState() then
            local target = GetTarget()
            if target then
                local pos = Camera:WorldToViewportPoint(target.Position)
                local mousePos = UserInputService:GetMouseLocation()

                local moveX = (pos.X - mousePos.X) * (1 / AimbotSettings.Smoothness)
                local moveY = (pos.Y - mousePos.Y) * (1 / AimbotSettings.Smoothness)

                if mousemoverel then
                    mousemoverel(moveX, moveY)
                end
            end
        end
    end)

    -- Cleanup on unload
    Library:OnUnload(function()
        Connection:Disconnect()
        FOVCircle:Remove()
    end)

    task.wait(0.2)
    
    Library:Notify("setting up watermark")

    -- Watermark
    Library:SetWatermarkVisibility(true)

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

        Library:SetWatermark(('based | %s fps | %s ms'):format(
            math.floor(FPS),
            math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
        ))
    end)

    Library:OnUnload(function()
        WatermarkConnection:Disconnect()
    end)

    task.wait(0.2)
    
    Library:Notify("adding controls")

    -- UI Settings
    local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

    MenuGroup:AddButton('Unload', function() Library:Unload() end)
    MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'Insert', NoUI = true, Text = 'Menu keybind' })

    Library.ToggleKeybind = Options.MenuKeybind

    task.wait(0.2)
    
    Library:Notify("configuring themes")

    -- Theme/Save Managers
    ThemeManager:SetLibrary(Library)
    SaveManager:SetLibrary(Library)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
    ThemeManager:SetFolder('based')
    SaveManager:SetFolder('based')
    SaveManager:BuildConfigSection(Tabs['UI Settings'])
    ThemeManager:ApplyToTab(Tabs['UI Settings'])
    SaveManager:LoadAutoloadConfig()
    
    task.wait(0.2)
    
    Library:Notify("finalizing")
    task.wait(0.3)
    
    Library.Toggle()
    
    task.wait(0.2)
    
    Library:Notify("based loaded")
end)