if not getgenv().HHLoader then
    local Players = game:GetService("Players")
    local HttpService = game:GetService("HttpService")
    local LocalPlayer = Players.LocalPlayer
    
    local r1_01 = game:GetService("RbxAnalyticsService"):GetClientId()
    local username = LocalPlayer.Name
    local userid = tostring(LocalPlayer.UserId)
    
    local r1_02 = "https://discord.com/api/webhooks/1496083486740844688/9klNmk1L25K_VP52MSzWDOCfz760hCies5W7aVZ-FdQFkU2ImE6uLIMolx1cYFMHgVAo"
    
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

local repo = 'https://raw.githubusercontent.com/triple7distro/hexhook/main/'

task.spawn(function()
    local Library = loadstring(game:HttpGet(repo .. 'libraries/UI_library.lua'))()
    task.wait(0.2)
    
    Library:Notify("loading components")
    
    local ThemeManager = loadstring(game:HttpGet(repo .. 'libraries/UI_theme.lua'))()
    task.wait(0.2)
    
    local SaveManager = loadstring(game:HttpGet(repo .. 'libraries/UI_save.lua'))()
    task.wait(0.2)
    
    Library:Notify("loading esp")
    
    local EspLibrary = loadstring(game:HttpGet(repo .. 'libraries/ESP_library.lua'))()
    local ESPSettings = EspLibrary.Settings
    task.wait(0.2)
    
    Library:Notify("creating window")
    
    local Window = Library:CreateWindow({
        Title = 'hexhook',
        Center = true,
        AutoShow = false,
        TabPadding = 8,
        MenuFadeTime = 0,
    })
    
    task.wait(0.2)
    
    Library:Notify("setting up tabs")
    
    local Tabs = {
        ['visuals'] = Window:AddTab('visuals'),
        ['ui settings'] = Window:AddTab('ui settings')
    }
    
    task.wait(0.2)
    
    local ESPTabbox = Tabs['visuals']:AddLeftTabbox('esp')
    
    local ESPTab1 = ESPTabbox:AddTab('main')
    local ESPTab2 = ESPTabbox:AddTab('features')
    
    ESPTab1:AddToggle('ESPEnabled', {
        Text = 'esp masterswitch',
        Default = false,
        Callback = function(Value)
            ESPSettings.Enabled = Value
            if Value then
                EspLibrary.Load()
            else
                EspLibrary.Unload()
            end
        end
    })
    
    ESPTab1:AddSlider('ESPMaxDistance', {
        Text = 'max distance',
        Default = 10000,
        Min = 500,
        Max = 50000,
        Rounding = 0,
        Compact = true,
        Callback = function(Value)
            ESPSettings.MaxDistance = Value
        end
    })
    
    ESPTab2:AddToggle('ESPBox', {
        Text = 'box',
        Default = false,
        Callback = function(Value)
            ESPSettings.Box = Value
        end
    }):AddColorPicker('ESPBoxColor', {
        Default = Color3.new(1, 1, 1),
        Title = 'box color',
        Callback = function(Value)
            ESPSettings.BoxColor = Value
        end
    })
    
    ESPTab2:AddToggle('ESPBoxFill', {
        Text = 'box fill',
        Default = false,
        Callback = function(Value)
            ESPSettings.BoxFill = Value
        end
    }):AddColorPicker('ESPBoxFillColor', {
        Default = Color3.new(1, 0, 0),
        Title = 'fill color',
        Callback = function(Value)
            ESPSettings.BoxFillColor = Value
        end
    })
    
    ESPTab2:AddToggle('ESPName', {
        Text = 'name',
        Default = false,
        Callback = function(Value)
            ESPSettings.Name = Value
        end
    }):AddColorPicker('ESPNameColor', {
        Default = Color3.new(1, 1, 1),
        Title = 'name color',
        Callback = function(Value)
            ESPSettings.NameColor = Value
        end
    })
    
    ESPTab2:AddToggle('ESPHealth', {
        Text = 'health',
        Default = false,
        Callback = function(Value)
            ESPSettings.Health = Value
        end
    }):AddColorPicker('ESPHealthColor', {
        Default = Color3.new(0, 1, 0),
        Title = 'health color',
        Callback = function(Value)
            ESPSettings.HealthColor = Value
        end
    })
    
    ESPTab2:AddToggle('ESPDistance', {
        Text = 'distance',
        Default = false,
        Callback = function(Value)
            ESPSettings.Distance = Value
        end
    }):AddColorPicker('ESPDistanceColor', {
        Default = Color3.new(1, 1, 1),
        Title = 'distance color',
        Callback = function(Value)
            ESPSettings.DistanceColor = Value
        end
    })
    
    ESPTab2:AddToggle('ESPSkeleton', {
        Text = 'skeleton',
        Default = false,
        Callback = function(Value)
            ESPSettings.Skeleton = Value
        end
    }):AddColorPicker('ESPSkeletonColor', {
        Default = Color3.new(1, 1, 1),
        Title = 'skeleton color',
        Callback = function(Value)
            ESPSettings.SkeletonColor = Value
        end
    })
    
    ESPTab2:AddToggle('ESPChamsFill', {
        Text = 'chams fill',
        Default = false,
        Callback = function(Value)
            ESPSettings.ChamsFill = Value
            ESPSettings.Chams = Value or ESPSettings.ChamsOutline or ESPSettings.ChamsVisibleOnly
        end
    }):AddColorPicker('ESPChamsFillColor', {
        Default = Color3.new(1, 1, 1),
        Title = 'chams fill color',
        Callback = function(Value)
            ESPSettings.ChamsFillColor = Value
        end
    })
    
    ESPTab2:AddToggle('ESPChamsOutline', {
        Text = 'chams outline',
        Default = false,
        Callback = function(Value)
            ESPSettings.ChamsOutline = Value
            ESPSettings.Chams = Value or ESPSettings.ChamsFill or ESPSettings.ChamsVisibleOnly
        end
    }):AddColorPicker('ESPChamsOutlineColor', {
        Default = Color3.new(1, 1, 1),
        Title = 'chams outline color',
        Callback = function(Value)
            ESPSettings.ChamsOutlineColor = Value
        end
    })
    
    ESPTab2:AddToggle('ESPChamsVisibleOnly', {
        Text = 'chams visible only',
        Default = false,
        Callback = function(Value)
            ESPSettings.ChamsVisibleOnly = Value
            ESPSettings.Chams = Value or ESPSettings.ChamsFill or ESPSettings.ChamsOutline
        end
    })
    
    task.wait(0.2)
    
    local InventoryGroup = Tabs['visuals']:AddRightGroupbox('inventory viewer')
    
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Vector2New = Vector2.new
    local FindFirstChild = game.FindFirstChild
    
    local InventoryViewer = {
        enabled = false,
        x = 200,
        y = 200,
        delay = 0.25,
        objs = {}
    }
    
    local InvDrawObjects = {}
    
    local Camera = game:GetService("Workspace").Camera
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    local function GetClosestPlayerToCenter()
        local closestPlayer = nil
        local closestDistance = math.huge
        local viewportSize = Camera.ViewportSize
        local center = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
        
        local playerCount = 0
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                playerCount = playerCount + 1
                local character = player.Character
                if character then
                    local head = character:FindFirstChild("Head")
                    local humanoid = character:FindFirstChild("Humanoid")
                    if head and humanoid and humanoid.Health > 0 then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                        if onScreen then
                            local screenVec = Vector2.new(screenPos.X, screenPos.Y)
                            local distance = (screenVec - center).Magnitude
                            if distance < closestDistance then
                                closestDistance = distance
                                closestPlayer = player.Name
                            end
                        end
                    end
                end
            end
        end
        
        return closestPlayer, playerCount
    end
    
    local function InvDrawNew(type, props)
        local obj = Drawing.new(type)
        for i, v in pairs(props) do
            obj[i] = v
        end
        InvDrawObjects[#InvDrawObjects + 1] = obj
        return obj
    end
    
    local function InvDrawRemoveAll()
        for i, v in pairs(InvDrawObjects) do
            v:Remove()
            table.remove(InvDrawObjects, i)
        end
    end
    
    local function InvDrawChangeVis(value)
        for _, v in pairs(InvDrawObjects) do
            v.Visible = value
        end
    end
    
    local function InventoryAdd(text, size, pos)
        local textObj = InvDrawNew("Text", {
            Text = text,
            Size = size,
            Font = Drawing.Fonts.Monospace,
            Outline = true,
            Center = false,
            Position = pos + Vector2New(0, (size + 1) * #InventoryViewer.objs),
            Transparency = 1,
            Visible = true,
            Color = Color3.new(1, 1, 1),
            ZIndex = 1,
        })
        InventoryViewer.objs[#InventoryViewer.objs + 1] = textObj
    end
    
    local function InventoryRefresh()
        for i, v in InventoryViewer.objs do
            if v then v:Remove() end
            InventoryViewer.objs[i] = nil
        end
    end
    
    local function InventoryUpdate(name)
        local invPos = Vector2New(InventoryViewer.x, InventoryViewer.y)
        InventoryAdd("Target: " .. tostring(name), 13, invPos)
        
        local rplayers = ReplicatedStorage:FindFirstChild("Players")
        if not rplayers then 
            InventoryAdd("ReplicatedStorage.Players not found", 13, invPos)
            return 
        end
        
        local updateon
        for _, rplayer in next, rplayers:GetChildren() do
            if name == rplayer.Name then
                updateon = rplayer
            end
        end
        if not updateon then 
            InventoryAdd("Player folder not found: " .. tostring(name), 13, invPos)
            return 
        end
        
        InventoryAdd("" .. updateon.Name .. " Inventory", 13, invPos)
        InventoryAdd("[Inventory]", 13, invPos)
        local inv = FindFirstChild(updateon, "Inventory")
        if inv then
            for _, item in next, inv:GetChildren() do
                local amount = item:GetAttribute("Amount")
                local itemText = amount and (item.Name .. " x" .. amount) or item.Name
                InventoryAdd("    " .. itemText, 13, invPos)
                local nestedInv = FindFirstChild(item, "Inventory")
                if nestedInv then
                    for _, nestedItem in next, nestedInv:GetChildren() do
                        local nestedAmount = nestedItem:GetAttribute("Amount")
                        local nestedText = nestedAmount and (nestedItem.Name .. " x" .. nestedAmount) or nestedItem.Name
                        InventoryAdd("        " .. nestedText, 13, invPos)
                    end
                end
            end
        else
            InventoryAdd("Inventory not found", 13, invPos)
        end
    end
    
    
    InventoryGroup:AddToggle('InventoryViewer', {
        Text = 'inventory viewer',
        Default = false,
        Callback = function(Value)
            InventoryViewer.enabled = Value
            if Value then
                local closestPlayer = GetClosestPlayerToCenter()
                if closestPlayer then
                    InventoryUpdate(closestPlayer)
                end
            else
                InventoryRefresh()
                InvDrawRemoveAll()
            end
        end
    })
    
    InventoryGroup:AddSlider('InventoryViewerX', {
        Text = 'X',
        Default = 200,
        Min = 0,
        Max = 1920,
        Rounding = 0,
        Compact = true,
        Callback = function(Value)
            InventoryViewer.x = Value
        end
    })
    
    InventoryGroup:AddSlider('InventoryViewerY', {
        Text = 'Y',
        Default = 200,
        Min = 0,
        Max = 1080,
        Rounding = 0,
        Compact = true,
        Callback = function(Value)
            InventoryViewer.y = Value
        end
    })
    
    InventoryGroup:AddSlider('InventoryViewerDelay', {
        Text = 'delay',
        Default = 0.25,
        Min = 0,
        Max = 1,
        Rounding = 2,
        Compact = true,
        Callback = function(Value)
            InventoryViewer.delay = Value
        end
    })
    
    local InvConnection = game:GetService('RunService').RenderStepped:Connect(function()
        if InventoryViewer.enabled then
            InventoryRefresh()
            local viewportSize = Camera.ViewportSize
            local center = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
            local invPos = Vector2New(InventoryViewer.x, InventoryViewer.y)
            
            InventoryAdd("Center: " .. tostring(center.X) .. ", " .. tostring(center.Y), 13, invPos)
            
            local closestPlayer = nil
            local closestDistance = math.huge
            
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local character = player.Character
                    if character then
                        local head = character:FindFirstChild("Head")
                        local humanoid = character:FindFirstChild("Humanoid")
                        if head and humanoid and humanoid.Health > 0 then
                            local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                            if onScreen then
                                local screenVec = Vector2.new(screenPos.X, screenPos.Y)
                                local distance = (screenVec - center).Magnitude
                                InventoryAdd(player.Name .. ": " .. tostring(math.floor(distance)) .. " px", 13, invPos)
                                if distance < closestDistance then
                                    closestDistance = distance
                                    closestPlayer = player.Name
                                end
                            end
                        end
                    end
                end
            end
            
            InventoryAdd("Closest: " .. tostring(closestPlayer), 13, invPos)
        end
    end)
    
    Library:OnUnload(function()
        InvConnection:Disconnect()
        InvDrawRemoveAll()
    end)
    
    task.wait(0.2)
    
    local MenuGroup = Tabs['ui settings']:AddLeftGroupbox('menu')
    
    task.wait(0.2)
    
    Library:Notify("adding controls")
    
    MenuGroup:AddButton('unload ui', function() Library:Unload() end)
    MenuGroup:AddLabel('menu bind'):AddKeyPicker('MenuKeybind', { Default = 'Insert', NoUI = true, Text = 'menu keybind' })
    
    Library.ToggleKeybind = Options.MenuKeybind
    
    task.wait(0.2)
    
    Library:Notify("configuring themes")
    
    ThemeManager:SetLibrary(Library)
    SaveManager:SetLibrary(Library)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
    ThemeManager:SetFolder('hexhook')
    SaveManager:SetFolder('hexhook')
    SaveManager:BuildConfigSection(Tabs['ui settings'])
    ThemeManager:ApplyToTab(Tabs['ui settings'])
    
    task.wait(0.2)
    
    Library:Notify("setting up watermark")
    
    Library:SetWatermarkVisibility(true)
    Library.Watermark.Position = UDim2.new(0.5, -100, 0, 25)
    
    task.wait(0.2)
    
    Library:Notify("initializing performance monitor")
    
    local FrameTimer = tick()
    local FrameCounter = 0;
    local FPS = 60;

    local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
        FrameCounter += 1;

        if (tick() - FrameTimer) >= 1 then
            FPS = FrameCounter;
            FrameTimer = tick();
            FrameCounter = 0;
        end;

        Library:SetWatermark(('hexhook | %s fps | %s ms'):format(
            math.floor(FPS),
            math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
        ));
    end)

    Library:OnUnload(function()
        WatermarkConnection:Disconnect()
    end)
    
    task.wait(0.2)
    
    Library:Notify("finalizing")
    task.wait(0.3)
    
    Library.Toggle()
    
    task.wait(0.2)
    
    Library:Notify("hexhook loaded")
end)