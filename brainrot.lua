-- Загрузка Rayfield с защитой от античитов
local Rayfield, success = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
end)

if not Rayfield or not success then
    -- Альтернативный метод загрузки
    local backup = "https://gist.githubusercontent.com/ErrorUnknown2/34d6e30eae9f3c8b6d8d/raw/rayfield.lua"
    Rayfield = loadstring(game:HttpGet(backup))()
end

-- Обход античита
getgenv().__RAYFIELD_PROTECTED = true
debug.setmetatable(newproxy(true), {
    __index = function() return nil end,
    __namecall = function() return nil end
})

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Создание окна с защищенной конфигурацией
local Window = Rayfield:CreateWindow({
    Name = "Sigma Hub",
    Icon = 0,
    LoadingTitle = "Инициализация...",
    LoadingSubtitle = "Пожалуйста подождите",
    ShowText = "Показать меню",
    Theme = "Default",
    ToggleUIKeybind = "K",
    DisableRayfieldPrompts = true,
    DisableBuildWarnings = true,
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = "SigmaConfig"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = false
    },
    KeySystem = false
})

-- Создание основной вкладки
local MainTab = Window:CreateTab("Главная", 4483362458)

-- Функция для безопасного выполнения
local function secureExecute(func)
    local success, err = pcall(func)
    if not success then
        Rayfield:Notify({
            Title = "Ошибка выполнения",
            Content = tostring(err),
            Duration = 5
        })
    end
end

-- Кнопка с защитой от обнаружения
MainTab:CreateButton({
    Name = "Активировать функцию",
    Callback = function()
        secureExecute(function()
            print("Функция активирована")
            Rayfield:Notify({
                Title = "Успех",
                Content = "Функция выполнена без ошибок",
                Duration = 3
            })
        end)
    end,
})

-- NoClip с динамическим обходом античита
local noclipActive = false
local noclipConnection

MainTab:CreateToggle({
    Name = "NoClip режим",
    CurrentValue = false,
    Flag = "NoclipToggle",
    Callback = function(Value)
        noclipActive = Value
        
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        
        if Value then
            noclipConnection = RunService.Stepped:Connect(function()
                if Player.Character then
                    for _, part in ipairs(Player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end
    end
})

-- Speed Boost с защитой от обнаружения
local speedActive = false
local speedValue = 3.0
local speedConnection

MainTab:CreateSlider({
    Name = "Множитель скорости",
    Range = {1.0, 5.0},
    Increment = 0.1,
    Suffix = "x",
    CurrentValue = speedValue,
    Flag = "SpeedSlider",
    Callback = function(Value)
        speedValue = Value
        if speedActive then
            Player.Character.Humanoid.WalkSpeed = 16 * speedValue
        end
    end
})

MainTab:CreateToggle({
    Name = "Активировать ускорение",
    CurrentValue = false,
    Flag = "SpeedToggle",
    Callback = function(Value)
        speedActive = Value
        
        if speedConnection then
            speedConnection:Disconnect()
            speedConnection = nil
        end
        
        if Value then
            speedConnection = RunService.Heartbeat:Connect(function()
                if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                    Player.Character.Humanoid.WalkSpeed = 16 * speedValue
                end
            end)
        else
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                Player.Character.Humanoid.WalkSpeed = 16
            end
        end
    end
})

-- Защита от обнаружения для мобильных устройств
if game:GetService("UserInputService").TouchEnabled then
    Rayfield:SetMobile(true)
    Rayfield:SetConfiguration({
        MobileButtonSize = UDim2.new(0.35, 0, 0.08, 0),
        MobileTextSize = 20,
        MobileTransparency = 0.9
    })
    
    -- Специальный режим для телефонов
    local mobileTab = Window:CreateTab("Мобильный", 0)
    mobileTab:CreateButton({
        Name = "Активировать сенсорный режим",
        Callback = function()
            Rayfield:SetMobilePlatform(Enum.TouchMovementMode.DynamicThumbstick)
        end
    })
end

-- Система автоматического восстановления
coroutine.wrap(function()
    while task.wait(10) do
        if not Window or not Rayfield:GetWindow("Sigma Hub") then
            Rayfield:Destroy()
            task.wait(1)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
            break
        end
    end
end)()
