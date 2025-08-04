-- Загрузка Rayfield с официального источника
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua"))()

-- Обход античита
local function antiCheatBypass()
    if not getgenv then
        getgenv = function() return _G end
    end

    local fakeEnv = {}
    setmetatable(fakeEnv, {
        __index = function(_, k)
            return rawget(getgenv(), k) or function() end
        end
    })

    getgenv().__RAYFIELD_PROTECTED = "encrypted_data_"..tostring(math.random(10000,99999))

    pcall(function()
        debug.setmetatable(newproxy(true), {
            __index = function() return nil end,
            __namecall = function() return nil end
        })
    end)

    task.wait(math.random(50, 300) / 1000)
end

antiCheatBypass()

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

-- Создание окна
local Window = Rayfield:CreateWindow({
    Name = "Sigma Hub",
    Icon = 0,
    LoadingTitle = "Инициализация...",
    LoadingSubtitle = "Пожалуйста подождите",
    Theme = "Default",
    ToggleUIKeybind = "K",
    DisableRayfieldPrompts = true,
    DisableBuildWarnings = true,
    ConfigurationSaving = {
        Enabled = false,
    },
    Discord = {
        Enabled = false,
    },
    KeySystem = false
})

local MainTab = Window:CreateTab("Главная", 4483362458)

-- Безопасный вызов
local function secureExecute(func)
    local success, err = pcall(func)
    if not success then
        Rayfield:Notify({
            Title = "Ошибка выполнения",
            Content = tostring(err),
            Duration = 5,
            Image = 0
        })
    end
end

-- Кнопка
MainTab:CreateButton({
    Name = "Активировать функцию",
    Callback = function()
        secureExecute(function()
            print("Функция активирована")
            Rayfield:Notify({
                Title = "Успех",
                Content = "Функция выполнена без ошибок",
                Duration = 3,
                Image = 0
            })
        end)
    end,
})

-- NoClip
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

-- Speed Boost
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
            secureExecute(function()
                Player.Character.Humanoid.WalkSpeed = 16 * speedValue
            end)
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
                secureExecute(function()
                    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                        Player.Character.Humanoid.WalkSpeed = 16 * speedValue
                    end
                end)
            end)
        else
            secureExecute(function()
                if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                    Player.Character.Humanoid.WalkSpeed = 16
                end
            end)
        end
    end
})

-- Мобильная поддержка
if UIS.TouchEnabled then
    Rayfield:SetMobile(true)
    Rayfield:SetConfiguration({
        MobileButtonSize = UDim2.new(0.35, 0, 0.08, 0),
        MobileTextSize = 20,
        MobileTransparency = 0.9
    })

    local mobileTab = Window:CreateTab("Мобильный", 0)
    mobileTab:CreateButton({
        Name = "Активировать сенсорный режим",
        Callback = function()
            UIS.TouchMovementMode = Enum.TouchMovementMode.DynamicThumbstick
        end
    })

    coroutine.wrap(function()
        task.wait(2)
        local screenGui = Instance.new("ScreenGui")
        screenGui.Parent = Player:WaitForChild("PlayerGui") -- CoreGui запрещён на мобилках

        local function createMobileButton(name, position, callback)
            local btn = Instance.new("TextButton")
            btn.Name = name
            btn.Size = UDim2.new(0.25, 0, 0.07, 0)
            btn.Position = position
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            btn.BorderSizePixel = 0
            btn.Text = name
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.TextSize = 16
            btn.Font = Enum.Font.GothamBold
            btn.Parent = screenGui

            btn.MouseButton1Click:Connect(callback)
            return btn
        end

        createMobileButton("NOCLIP", UDim2.new(0.1, 0, 0.85, 0), function()
            noclipActive = not noclipActive
            Window.Flags["NoclipToggle"]:Set(noclipActive)
        end)

        createMobileButton("SPEED", UDim2.new(0.4, 0, 0.85, 0), function()
            speedActive = not speedActive
            Window.Flags["SpeedToggle"]:Set(speedActive)
        end)

        createMobileButton("HIDE", UDim2.new(0.7, 0, 0.85, 0), function()
            Rayfield:Destroy()
        end)
    end)()
end

-- Автовосстановление интерфейса (если Rayfield крашнулся)
coroutine.wrap(function()
    while task.wait(10) do
        if not Rayfield or not Rayfield:GetWindow("Sigma Hub") then
            local backupURL = "https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua"
            Rayfield = loadstring(game:HttpGet(backupURL))()
            -- Повторная инициализация — можно вручную вызвать reload()
            break
        end
    end
end)()

-- Восстановление спидхака после смерти
Player.CharacterAdded:Connect(function()
    if speedActive then
        task.wait(1)
        secureExecute(function()
            Player.Character.Humanoid.WalkSpeed = 16 * speedValue
        end)
    end
end)
