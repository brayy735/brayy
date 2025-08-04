-- erafox/StealABrainrot-Full v2.0 (04.08.2025)
-- Загрузка библиотеки
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

-- Анти-детект система
local function securityCheck()
    if not getgenv then
        getgenv = function() return _G end
    end
    getgenv().SecureMode = "erafox_jaleyBreak_v2"
    debug.setmetatable(newproxy(true), {__index = function() return nil end})
end

securityCheck()

-- Создание мобильно-оптимизированного интерфейса
local Window = Rayfield:CreateWindow({
    Name = "BRAINROT CHEAT",
    LoadingTitle = "EraFox Mobile Toolkit",
    LoadingSubtitle = "Steal a Brainrot v2.4.1",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false,
    MobileCompatible = true,
    MobileTransparency = 0.85
})

--// НАСТРОЙКИ ФУНКЦИЙ //--
local settings = {
    noclip = false,
    speed = false,
    speedMultiplier = 3.0,
    antiragdoll = true
}

--// GUI ЭЛЕМЕНТЫ //--
-- NoClip переключатель
Window:CreateToggle({
    Name = "NOFLY MODE",
    CurrentValue = settings.noclip,
    Flag = "NoclipToggle",
    Callback = function(Value)
        settings.noclip = Value
        Rayfield:Notify({
            Title = Value and "NoClip АКТИВИРОВАН" or "NoClip ОТКЛЮЧЕН",
            Content = Value and "Столкновения отключены" or "Столкновения включены",
            Duration = 2
        })
    end
})

-- SpeedBoost слайдер и переключатель
Window:CreateSlider({
    Name = "СКОРОСТЬ",
    Range = {1.0, 5.0},
    Increment = 0.1,
    Suffix = "x",
    CurrentValue = settings.speedMultiplier,
    Flag = "SpeedSlider",
    Callback = function(Value)
        settings.speedMultiplier = Value
    end
})

Window:CreateToggle({
    Name = "ВКЛ/ВЫКЛ СПРИНТ",
    CurrentValue = settings.speed,
    Flag = "SpeedToggle",
    Callback = function(Value)
        settings.speed = Value
    end
})

-- AntiRagdoll переключатель
Window:CreateToggle({
    Name = "ANTI-RAGDOLL",
    CurrentValue = settings.antiragdoll,
    Flag = "AntiRagdollToggle",
    Callback = function(Value)
        settings.antiragdoll = Value
    end
})

--// МОБИЛЬНЫЕ ИНСТРУМЕНТЫ //--
local MobileSection = Window:CreateSection("Мобильные настройки")

-- Активация сенсорного управления
MobileSection:CreateButton({
    Name = "🖐️ Активировать сенсорный режим",
    Callback = function()
        Rayfield:SetMobile(true)
        Rayfield:SetConfiguration({
            MobileButtonSize = UDim2.new(0.3, 0, 0.07, 0),
            MobileTextSize = 20
        })
        Rayfield:SetMobilePlatform(Enum.TouchMovementMode.DynamicThumbstick)
    end
})

-- Быстрые кнопки для мобильных
local function createQuickButton(name, position, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0.25, 0, 0.08, 0)
    btn.Position = position
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 18
    btn.Font = Enum.Font.GothamBold
    btn.Parent = Rayfield:GetMobileScreenGui()
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Создание быстрых кнопок
local noclipBtn = createQuickButton("NOFLY", UDim2.new(0.1, 0, 0.82, 0), function()
    settings.noclip = not settings.noclip
    noclipBtn.Text = settings.noclip and "NOFLY ON" or "NOFLY OFF"
end)

local speedBtn = createQuickButton("SPEED", UDim2.new(0.4, 0, 0.82, 0), function()
    settings.speed = not settings.speed
    speedBtn.Text = settings.speed and "SPEED ON" or "SPEED OFF"
end)

local antiragBtn = createQuickButton("NO-RAG", UDim2.new(0.7, 0, 0.82, 0), function()
    settings.antiragdoll = not settings.antiragdoll
    antiragBtn.Text = settings.antiragdoll and "NO-RAG ON" or "NO-RAG OFF"
end)

--// ОСНОВНОЙ ЦИКЛ //--
RunService.Heartbeat:Connect(function()
    -- NoClip
    if settings.noclip and Player.Character then
        for _, part in ipairs(Player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
    
    -- SpeedBoost
    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = settings.speed and (16 * settings.speedMultiplier) or 16
    end
    
    -- AntiRagdoll
    if settings.antiragdoll then
        for _, child in ipairs(workspace:GetChildren()) do
            if child.Name == "Ragdoll" and child:IsA("Model") then
                task.wait(0.05)
                child:BreakJoints()
                task.wait(0.3)
                child:Destroy()
            end
        end
    end
    
    -- Мобильная оптимизация
    if Rayfield:GetMobile() then
        local battery = UIS:GetBatteryInfo()
        if battery and battery.BatteryLevel < 15 then
            Rayfield:SetConfiguration({MobileTransparency = 0.95})
        end
    end
end)

--// СИСТЕМА БЕЗОПАСНОСТИ //--
local SecuritySection = Window:CreateSection("Безопасность")

-- Скрытие интерфейса
SecuritySection:CreateButton({
    Name = "👁️ Скрыть GUI",
    Callback = function()
        Rayfield:SetConfiguration({
            OverrideTheme = {
                Background = Color3.fromRGB(0, 0, 0, 0),
                Glow = Color3.fromRGB(0, 0, 0, 0),
                Accent = Color3.fromRGB(0, 0, 0, 0)
            },
            Transparency = 1
        })
    end
})

-- Экстренное отключение
SecuritySection:CreateButton({
    Name = "⚠️ ЭКСТРЕННОЕ ОТКЛЮЧЕНИЕ",
    Callback = function()
        Rayfield:Destroy()
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = 16
        end
        getgenv().SecureMode = nil
    end
})

-- Защита от обновлений
while true do
    if not Rayfield:GetWindow("BRAINROT CHEAT") then
        loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
        task.wait(5)
    end
    task.wait(10)
end
